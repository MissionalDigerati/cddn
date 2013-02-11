require 'spec_helper'

describe User do
  context "validations" do
    
    it "should create a valid contact" do 
      FactoryGirl.create(:defaulted_user).should be_valid
    end
    
    it "should require an the presence of an email address" do
      FactoryGirl.build(:defaulted_user, email: nil).should_not be_valid
    end
    
    it "should require a valid email address" do
      FactoryGirl.build(:defaulted_user, email: "fred").should_not be_valid
    end
    
    it "should require a password" do
      FactoryGirl.build(:defaulted_user, password: nil).should_not be_valid
    end
    
    it "should allow users to input data about themselves" do
      user = FactoryGirl.create(:defaulted_user, first_name: "rory", last_name: "williams", nickname: "the nose", primary_role: "developer", church: "mormon", bio: "text")
      user.first_name.should == "rory"
    end
    
    it "should require a unique email address" do
      amy = FactoryGirl.create(:defaulted_user, email: "AmyPond@tardis.net")
      FactoryGirl.build(:defaulted_user, email: "AmyPond@tardis.net", nickname: "the legs").should_not be_valid
    end
    
    it "should require the uniqueness of a nickname" do
      rory = FactoryGirl.create(:defaulted_user, nickname: "the nose")
      FactoryGirl.build(:defaulted_user, email: "testing@fake.com", nickname: "the nose").should_not be_valid
    end
    
    it "nil nickname issue validation test" do
      nick = FactoryGirl.create(:defaulted_user, nickname: nil)
      FactoryGirl.create(:defaulted_user, email: "testing@fake.com", nickname: nil).should be_valid
    end
    
    it "should delete attendee and event records if the user who created it is deleted" do
       user = FactoryGirl.create(:defaulted_user)
       event = FactoryGirl.create(:defaulted_event)
       FactoryGirl.create(:defaulted_attendee, user_id: user.id, event_id: event.id, attendee_type: "creator").should be_valid
       user.destroy
       Attendee.all.length.should == 0
       Event.all.length.should == 1
     end
     
    it "should delete the network records if the user that owns them is deleted/destroyed" do
      user = FactoryGirl.create(:defaulted_user)
      social_media = FactoryGirl.create(:social_medium, service: "facebook")
      network = FactoryGirl.create(:defaulted_network, social_media_id: social_media.id, networkable_type: "User", networkable_id: user.id).should be_valid
      Network.all.length.should == 1
      user.destroy
      Network.all.length.should == 0
    end
  end
  
  
  describe "aftersave" do
    it "should created corresponding programmings records after the event is save so long as there are programming language ids provided in the programming_language_ids params" do
      language = FactoryGirl.create(:defaulted_programming_language, language: "Ruby")
      user = FactoryGirl.build(:defaulted_user, programming_language_ids: [1])
      user.save
      user.programmings.length.should == 1
      user.programmings.first.programmable_id.should == user.id
      user.programmings.first.programmable_type.should == "User"
      user.programmings.first.programming_language_id.should == language.id
    end
    
    it "should not create a programmings record for the event if no programming language ids are passed" do
      user = FactoryGirl.build(:defaulted_user, programming_language_ids: nil)
      user.save
      user.programmings.length.should == 0
    end
  end
  
  
  
  context "methods" do
    
    it "should return a twitter instance if twitter is the provider." do
      user_hash = OmniAuth.config.add_mock(:twitter, info: {nickname: "fred"})
      user = User.omniauth_all(user_hash)
      user.uid.should == "1234"
      user.provider.should == "twitter"
      user.email.should == "1234@noemailprovided.com"
      user.nickname.should == "fred"
      user.first_name.should == nil
      user.last_name.should == nil
    end
    
    it "should return github instance if github is the provider." do
      user_hash = OmniAuth.config.add_mock(:github, info: {nickname: 'hank', email: "user@githubexample.com"})
      user = User.omniauth_all(user_hash)
      user.uid.should == "1234"
      user.provider.should == "github"
      user.email.should == "user@githubexample.com"
      user.nickname.should == "hank"
      user.first_name.should == nil
      user.last_name.should == nil
    end
    
    it "should return a facbook instance if facebook is the provider" do
      user_hash = OmniAuth.config.add_mock(:facebook, info: {nickname: 'martin.mcfly.56679', first_name: 'fred', last_name: 'flintstone', name: 'fred flintstone', email: "user@facebookexample.com"})
      user = User.omniauth_all(user_hash)
      user.uid.should == "1234"
      user.provider.should == "facebook"
      user.email.should == "user@facebookexample.com"
      user.nickname.should == "fred flintstone"
      user.first_name.should == "fred"
      user.last_name.should == "flintstone"
    end
    
    it "should use the name paramater if facebook is the proider instead of nickname like twitter or github would use" do
      user_hash = OmniAuth.config.add_mock(:facebook, info: {nickname: 'martin.mcfly.56679', name: 'fred flintstone'})
      user = User.omniauth_all(user_hash)
      user.nickname.should == "fred flintstone"
      user.nickname.should_not == "martin.mcfly.56679"
    end
    
    it "should create an email with information from the hash if an email is not provided" do
      user_hash = OmniAuth.config.add_mock(:github, uid: "1234", info: {nickname: 'hank', email: nil})
      user = User.omniauth_all(user_hash)
      user.email.should == "1234@noemailprovided.com"
    end
    
    it "should use the email address if one is provided and not generate one with the uid" do
      user_hash = OmniAuth.config.add_mock(:github, uid: "1234", info: {nickname: 'hank', email: "userexample@github.com"})
      user = User.omniauth_all(user_hash)
      user.email.should == "userexample@github.com"
      user.email.should_not == "1234@noemailprovided.com"
    end
    
    it "should set the user's please update column to true, thus removing the please update message" do
      user = FactoryGirl.create(:defaulted_user, please_update: false)
      User.update_notification(user)
      user.please_update.should == true
    end
    
  end
  
end
