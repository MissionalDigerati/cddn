require 'spec_helper'

describe ApplicationHelper do
  context "methods" do
    
    it "should retrun the user's nickname and provider rather than the email" do
      user = FactoryGirl.build(:defaulted_user, email: nil, encrypted_password: nil,  provider: "twitter", nickname: "Nickname123")
      logged_in_as(user).should == "Nickname123 from twitter"
    end
    
    it "should return the user's email becuase the nickname and provider are not present" do
      user = FactoryGirl.build(:defaulted_user, email: "123fake@emailtest.com", provider: nil, nickname: nil)
      logged_in_as(user).should == "123fake@emailtest.com"
    end
    
  end
end