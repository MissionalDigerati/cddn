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
  end
  
end
