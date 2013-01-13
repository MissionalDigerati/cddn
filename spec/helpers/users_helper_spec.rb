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
    
    
    it "should return the event creator nickname if available" do
      user = FactoryGirl.create(:defaulted_user, nickname: "fred")
      event = FactoryGirl.create(:defaulted_event)
      attendee = FactoryGirl.create(:defaulted_attendee, user_id: user.id, event_id: event.id, attendee_type: "creator")
      attendee_creator_name(event).should == "fred"
    end
    
    it "should return the events creator's first name if it is available and nickname is not available" do
      user = FactoryGirl.create(:defaulted_user, first_name: "rory")
      event = FactoryGirl.create(:defaulted_event)
      attendee = FactoryGirl.create(:defaulted_attendee, user_id: user.id, event_id: event.id, attendee_type: "creator")
      attendee_creator_name(event).should == "rory"
    end 
    
    it "should return the user's email if both the nickname and the first name are unavailable" do
      user = FactoryGirl.create(:defaulted_user, email: "fake@fake.com")
      event = FactoryGirl.create(:defaulted_event)
      attendee = FactoryGirl.create(:defaulted_attendee, user_id: user.id, event_id: event.id, attendee_type: "creator")
      attendee_creator_name(event).should == "fake@fake.com"
    end
    
  end
  
end