require 'spec_helper'

describe Event do
  describe "validations" do
    
    it "should create a valid record" do
      FactoryGirl.create(:defaulted_event).should be_valid
    end
    
    it "should not create a valid event without all of the require fields" do
      FactoryGirl.build(:defaulted_event, title: nil).should_not be_valid
    end
    
  end
  
  describe "methods" do
    
    it "should return the user nickname of the user who created the event if it is available when an event is supplied" do
      event = FactoryGirl.create(:defaulted_event)
      user = FactoryGirl.create(:defaulted_user, nickname: "The Master")
      attendee = FactoryGirl.create(:defaulted_attendee, user_id: user.id, event_id: event.id, attendee_type: "creator")
      Event.event_create_by(event).should == "The Master"
    end
    
    it "should return the user email of the user who created the event if it is available when an event is supplied" do
      event = FactoryGirl.create(:defaulted_event)
      user = FactoryGirl.create(:defaulted_user, nickname: nil, email: "123@fakeemail.com")
      attendee = FactoryGirl.create(:defaulted_attendee, user_id: user.id, event_id: event.id, attendee_type: "creator")
      Event.event_create_by(event).should == "123@fakeemail.com"
    end
    
  end
end
