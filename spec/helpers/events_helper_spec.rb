require 'spec_helper'

describe EventsHelper do
  describe "methods" do
    
    it "should return the appropriate button to either attend, unattend an event. Or noting at all if you created the event and it should only display if it is an upcoming event" do
      FactoryGirl.create(:defaulted_state)
      FactoryGirl.create(:defaulted_country)
      user_that_created_event = FactoryGirl.create(:defaulted_user, nickname: "The Master", email: "creator@fake.com")
      event = FactoryGirl.create(:defaulted_event)
      event.event_dates.create(date_of_event: Time.now.to_date, time_of_event: Time.now)
      attendee = FactoryGirl.create(:defaulted_attendee, user_id: user_that_created_event.id, event_id: event.id, attendee_type: "creator")
      #if the user created the event, no button should display
      attend_event_button(user_that_created_event.id, event).should == ""
      
      user_that_attend_event = FactoryGirl.create(:defaulted_user, nickname: "The Doctor", email: "visitor@fake.com")
      attendee_attending_event = FactoryGirl.create(:defaulted_attendee, user_id: user_that_attend_event.id, event_id: event.id, attendee_type: "attendee")
      #this user will recieve an unattend button becuase the are already attending the event
      attend_event_button(user_that_attend_event.id, event).should == "<a href=\"/events/1/attend_event\" class=\"btn btn-mini\" data-method=\"put\" rel=\"nofollow\">Un-attend Event</a>"
      
      user_that_not_attend_event = FactoryGirl.create(:defaulted_user, nickname: "name", email: "name@fake.com")
      #this user will recieve an attend button becuase the are not already attending the event
      attend_event_button(user_that_not_attend_event.id, event).should == "<a href=\"/events/1/attend_event\" class=\"btn btn-mini\" data-method=\"put\" rel=\"nofollow\">Attend Event</a>"
      
      #it should recieve nil if the event has passed, nil should be returned for everyone
      past_event = FactoryGirl.create(:defaulted_event)
      past_event.event_dates.create(date_of_event: 1.week.ago.to_date, time_of_event: Time.now)
      attend_event_button(user_that_created_event.id, past_event).should == nil
      attend_event_button(user_that_attend_event.id, past_event).should == nil
      attend_event_button(user_that_not_attend_event.id, past_event).should == nil
    end
    
    it "should return a link to the event, unless the event is not approved, in which case it will return nothing" do
      FactoryGirl.create(:defaulted_state)
      FactoryGirl.create(:defaulted_country)
      approved_event = FactoryGirl.create(:defaulted_event)
      unapproved_event = FactoryGirl.create(:defaulted_event, approved_event: false)
      view_event(approved_event).should == "<a href=\"/events/1\" class=\"btn btn-mini btn-info\">View Event</a>"
      view_event(unapproved_event).should == nil
    end
    
  end
end

