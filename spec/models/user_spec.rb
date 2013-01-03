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
  end
  
  context "methods" do
    
    it "should return a twitter instance if twitter is the provider. Please note there is no email provided here and therefore creates an email address" do
      user_hash = OmniAuth.config.add_mock(:twitter, info: {nickname: "fred"})
      user = User.omniauth_all(user_hash)
      user.uid.should == "1234"
      user.provider.should == "twitter"
      user.email.should == "1234@noemailprovided.com"
      user.nickname.should == "fred"
      user.first_name.should == nil
      user.last_name.should == nil
    end
    
    it "should return github instance if github is the provider. Please note that email is provided here" do
      user_hash = OmniAuth.config.add_mock(:github, info: {nickname: 'hank', email: "user@githubexample.com"})
      user = User.omniauth_all(user_hash)
      user.uid.should == "1234"
      user.provider.should == "github"
      user.email.should == "user@githubexample.com"
      user.nickname.should == "hank"
      user.first_name.should == nil
      user.last_name.should == nil
    end
    
    it "should return a facbook instance if facebook is the provider. It should also use the name params as the users nickname as facebook is the provider" do
      user_hash = OmniAuth.config.add_mock(:facebook, info: {nickname: 'martin.mcfly.56679', first_name: 'fred', last_name: 'flintstone', name: 'fred flintstone', email: "user@facebookexample.com"})
      user = User.omniauth_all(user_hash)
      user.uid.should == "1234"
      user.provider.should == "facebook"
      user.email.should == "user@facebookexample.com"
      user.nickname.should == "fred flintstone"
      user.first_name.should == "fred"
      user.last_name.should == "flintstone"
    end
    
  end
  
end
