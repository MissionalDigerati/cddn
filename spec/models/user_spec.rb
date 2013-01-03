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
  
  # context "methods" do
  #     it "should return a user instance with user information" do
  # 
  #       user = User.from_twitter(user_hash)
  #       user.uid.should == "100004291362982"
  #     end
  #   end
  
end
