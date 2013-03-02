require 'spec_helper'

describe Event do
  describe "validations" do
    
    it "should create a valid record" do
      FactoryGirl.create(:defaulted_state)
      FactoryGirl.create(:defaulted_country)
      FactoryGirl.create(:defaulted_event).should be_valid
    end
    
    it "should not create a valid event without all of the require fields" do
      FactoryGirl.create(:defaulted_state)
      FactoryGirl.create(:defaulted_country)
      FactoryGirl.build(:defaulted_event, title: nil).should_not be_valid
    end
    
    it "should delete attendee records if the event who created it is deleted however it should not delete the user" do
      FactoryGirl.create(:defaulted_state)
      FactoryGirl.create(:defaulted_country)
      user = FactoryGirl.create(:defaulted_user)
      event = FactoryGirl.create(:defaulted_event)
      FactoryGirl.create(:defaulted_attendee, user_id: user.id, event_id: event.id, attendee_type: "creator").should be_valid
      event.destroy
      Attendee.all.length.should == 0
      User.first.should == user
    end
    
    it "should delete the network records if the event that owns them is deleted/destroyed" do
      FactoryGirl.create(:defaulted_state)
      FactoryGirl.create(:defaulted_country)
      user = FactoryGirl.create(:defaulted_user)
      event = FactoryGirl.create(:defaulted_event)
      attendee = FactoryGirl.create(:defaulted_attendee, user_id: user.id, event_id: event.id, attendee_type: "creator")
      social_media = FactoryGirl.create(:social_medium, service: "facebook")
      network = FactoryGirl.create(:defaulted_network, social_media_id: social_media.id, networkable_type: "Event", networkable_id: event.id).should be_valid
      Network.all.length.should == 1
      event.destroy
      Network.all.length.should == 0
    end
    
    it "should delete the programmigns records if the event that owns them is destroyed" do
      FactoryGirl.create(:defaulted_state)
      FactoryGirl.create(:defaulted_country)
      language = FactoryGirl.create(:defaulted_programming_language)
      event = FactoryGirl.create(:defaulted_event)
      tag = event.programmings.create({programming_language_id: language.id})
      Programming.all.length.should == 1
      event.destroy
      Programming.all.length.should == 0
    end
    
  end
  
  describe "aftersave" do
    it "should created corresponding programmings records after the event is save so long as there are programming language ids provided in the programming_language_ids params" do
      FactoryGirl.create(:defaulted_state)
      FactoryGirl.create(:defaulted_country)
      language = FactoryGirl.create(:defaulted_programming_language, language: "Ruby")
      event = FactoryGirl.build(:defaulted_event, lang_tokens: "1")
      event.save
      event.programmings.length.should == 1
      event.programmings.first.programmable_id.should == event.id
      event.programmings.first.programmable_type.should == "Event"
      event.programmings.first.programming_language_id.should == language.id
    end
    
    it "should not create a programmings record for the event if no programming language ids are passed" do
      FactoryGirl.create(:defaulted_state)
      FactoryGirl.create(:defaulted_country)
      event = FactoryGirl.build(:defaulted_event, lang_tokens: nil)
      event.save
      event.programmings.length.should == 0
    end
  end
  
  
  describe "methods" do
    it "should return queries based on programming languages associated with events. However if none are filtered, then it should return all events. However only events that are approved" do
      FactoryGirl.create(:defaulted_state)
      FactoryGirl.create(:defaulted_country)
      language = FactoryGirl.create(:defaulted_programming_language)
      approved_event_without_tag = FactoryGirl.create(:defaulted_event, title: "no_tag")
      FactoryGirl.create(:defaulted_event_date, event_id: approved_event_without_tag.id)
      unapproved_event = FactoryGirl.create(:defaulted_event, approved_event: false, title: "unapproved")
      FactoryGirl.create(:defaulted_event_date, event_id: unapproved_event.id)
      approved_event_with_tag = FactoryGirl.create(:defaulted_event, title: "approved_with_tag")
      FactoryGirl.create(:defaulted_event_date, event_id: approved_event_with_tag.id)
      tag = approved_event_with_tag.programmings.create({programming_language_id: language.id})
      #should only return 2 becasue the 3rd is not approved
      Event.upcoming_event_query(nil).length.should == 2
      #should only return 1 because it is filtered by a programming language
      Event.upcoming_event_query(1).length.should == 1
      Event.upcoming_event_query(1).first.title.should == "approved_with_tag"
    end
    
    it "should only return upcoming events not past events" do
      FactoryGirl.create(:defaulted_state)
      FactoryGirl.create(:defaulted_country)
      upcoming_event = FactoryGirl.create(:defaulted_event, title: "upcoming")
      FactoryGirl.create(:defaulted_event_date, event_id: upcoming_event.id)
      past_event = FactoryGirl.create(:defaulted_event, title: "past_event")
      FactoryGirl.create(:defaulted_event_date, event_id: past_event.id, date_of_event: 1.week.ago.to_date)
      Event.upcoming_event_query(nil).length.should == 1
      Event.upcoming_event_query(nil).first.should == upcoming_event
    end
    
  end
  
end
