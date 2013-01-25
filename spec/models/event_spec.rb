require 'spec_helper'

describe Event do
  describe "validations" do
    
    it "should create a valid record" do
      FactoryGirl.create(:defaulted_event).should be_valid
    end
    
    it "should not create a valid event without all of the require fields" do
      FactoryGirl.build(:defaulted_event, title: nil).should_not be_valid
    end
    
    it "should delete attendee records if the event who created it is deleted however it should not delete the user" do
      user = FactoryGirl.create(:defaulted_user)
      event = FactoryGirl.create(:defaulted_event)
      FactoryGirl.create(:defaulted_attendee, user_id: user.id, event_id: event.id, attendee_type: "creator").should be_valid
      event.destroy
      Attendee.all.length.should == 0
      User.first.should == user
    end
    
    it "should delete the network records if the event that owns them is deleted/destroyed" do
      user = FactoryGirl.create(:defaulted_user)
      event = FactoryGirl.create(:defaulted_event)
      attendee = FactoryGirl.create(:defaulted_attendee, user_id: user.id, event_id: event.id, attendee_type: "creator")
      social_media = FactoryGirl.create(:social_medium, service: "facebook")
      network = FactoryGirl.create(:defaulted_network, social_media_id: social_media.id, networkable_type: "Event", networkable_id: event.id).should be_valid
      Network.all.length.should == 1
      event.destroy
      Network.all.length.should == 0
    end
    
  end
  
  describe "aftersave" do
    it "should created corresponding programmings records after the event is save so long as there are programming language ids provided in the programming_language_ids params" do
      language = FactoryGirl.create(:defaulted_programming_language, language: "Ruby")
      event = FactoryGirl.build(:defaulted_event, programming_language_ids: [1])
      event.save
      event.programmings.length.should == 1
      event.programmings.first.programmable_id.should == event.id
      event.programmings.first.programmable_type.should == "Event"
      event.programmings.first.programming_language_id.should == language.id
    end
    
    it "should not create a programmings record for the event if no programming language ids are passed" do
      event = FactoryGirl.build(:defaulted_event, programming_language_ids: nil)
      event.save
      event.programmings.length.should == 0
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
