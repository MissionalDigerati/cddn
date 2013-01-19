require 'spec_helper'

describe EventsHelper do
  describe "methods" do
    
    it "should return the appropriate button to either attend, unattend an event. Or noting at all if you created the event" do
      user_that_created_event = FactoryGirl.create(:defaulted_user, nickname: "The Master", email: "creator@fake.com")
      event = FactoryGirl.create(:defaulted_event)
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
    end
    
  end
end

