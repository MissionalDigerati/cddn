Feature: A logged in user should be able to create events as state they are attending them
	As a user
	I should be able to create events as well as manage them, as well as state my role in them. 
	I do not want users or visitors to be able to access the creation or editing functionality of events. However they can mark that they are attending them
	
	Scenario: A user should be able to create events, as an event approved user they should be redirected to the event show page
		Given I am a user "create_events_test" and I am logged in
		And I am on the home page
		When I click the "user_new_event" link
		Then I should be on the new event page
		And I fill in "Title" with "Rails meet up"
		And I fill in "Address 1" with "123 fake street"
		And I fill in "event_city_province" with "San Jose"
		And I fill in "Zip code" with "95123"
		And I fill in "event_event_date" with current time
		And I fill in "event_event_time" with current time
		And I click the "Submit" link
		Then I should see "Your Event has been created!"
		And I should be on the event show page for "Rails meet up"
		
	Scenario: A user that is not approved for event creation, should receive a message stating so after creating an event
		Given I am a user "unapproved_event_message" that is not approved for event creation, and I am logged in
		And I am on the home page
		When I click the "user_new_event" link
		Then I should be on the new event page
		And I fill in "Title" with "Rails meet up"
		And I fill in "Address 1" with "123 fake street"
		And I fill in "event_city_province" with "San Jose"
		And I fill in "Zip code" with "95123"
		And I fill in "event_event_date" with current time
		And I fill in "event_event_time" with current time
		And I click the "Submit" button
		Then I should see "Your Event has been submitted for approval, and will not be visible until approved"
		And I should be on the my events page for "unapproved_event_message"
		
	Scenario: A user that is approved for event creation should be able to edit their events, and should be redirected to the event show page
		Given I am a user "event_update_redirect", and I have an event "great_event", and I am logged in
		And I am on the home page
		When I click the "user_my_events" button
		And I click the "Edit Event" button for "great_event"
		And I fill in "Title" with "better_event"
		And I click the "Submit" button
		Then I should see "Your event was successfully updated."
		And I should be on the event show page for "better_event"
		
	Scenario: A user that is not approved for event creation should be able to edit their event, and should receive a message and be redirected to the my events page
		Given I am a user "unapproved_event_update_redirect", and I have an event "unapproved_redirect", and I am logged in, and I am not approved for event creation
		And I am on the home page
		When I click the "user_my_events" button
		And I click the "Edit Event" button for "unapproved_redirect"
		And I fill in "Title" with "still_not_approved"
		And I click the "Submit" button
		Then I should see "Your event has been update, and is still pending approval, and will not be visible until approved."
		And I should be on the my events page for "unapproved_event_update_redirect"
		
	Scenario: A user should not be able to create events if all the the required attributes are not present
		Given I am a user "create_events_failure_test" and I am logged in
		And I am on the home page
		When I click the "user_new_event" link
		Then I should be on the new event page
		When I click the "Submit" button
		Then I should see "Title can't be blank, Address 1 can't be blank, City province can't be blank, Zip code can't be blank, Event time can't be blank, and Event date can't be blank"
		
	Scenario: A visitor that is not logged in should not be able to access the the new events form page
		Given I am on the home page
		When I try to access the new event page
		Then I should be on the user sign in page
		And I should see "You need to sign in or sign up before continuing."
		
	Scenario: A user should be able to create an event and view it on the events index page
		Given I am a user "events_index_test" and I am logged in
		And I have an event "Testing event index"
		And I am on the home page
		When I click the "all_events" link
		Then I should be on the events index page
		And I should see "Testing event index"
	
	Scenario: A visitor that is not logged in should be able to view the event index page
		Given I am on the home page
		And I have an event "visitor event index test"
		When I visit the events index page
		Then I should see "visitor event index test"
		
	Scenario: A user that is logged in should be able to visit a show page for their own event
		Given I am a user "event_show_test", and I have an event "show_testing_self_test", and I am logged in
		And I am on the home page
		When I click the "all_events" button
		Then I should be on the events index page
		And I should see "show_testing_self_test"
		When I click the "View Event" button
		Then I should see "Created By: event_show_test@cddn.com"
		
	Scenario: A visitor that is not logged in should be able to view a show page for an event
		Given I am a user "event_show_test_for_visitor", and I have an event "show_testing_visitor_test", and I am not logged in 
		And I am on the home page
		When I visit the events index page
		Then I should see "show_testing_visitor_test"
		When I click the "View Event" button
		Then I should see "Created By: event_show_test_for_visitor@cddn.com"
		
	Scenario: A user should be able to view their events on the my index page
		Given I am a user "my_events_show", and I have an event "my_events_show_test", and I am logged in
		And I am on the home page
		When I click the "user_my_events" button
		And I should see "my_events_show_test" 
		
	Scenario: A visitor that is not logged in should not be able to view a users my events index page
		Given I am a user "my_event_visitor", and I have an event "my_event_visitor_test", and I am not logged in 
		And I am on the home page
		When I try to access the my events page for "my_event_visitor"
		Then I should be on the user sign in page
		And I should see "You need to sign in or sign up before continuing."

	Scenario: A user that is logged in should not be able to view another users my event page
		Given I am a user "my_event_user", and I have an event "my_event_user_test", and I am not logged in 
		And I am a user "testing123", and I have an event "testing999", and I am logged in
		And I am on the home page
		When I click the "user_my_events" button
		Then I should see "testing999"
		And I should not see "my_event_user_test"
		When I try to access the my events page for "my_event_user"
		Then I should see "testing999"
		And I should not see "my_event_user_test"
		
	Scenario: A visitor that is not logged in should not be to edit another users event
		Given I am a user "edit_event_visitor", and I have an event "edit_event_visitor_test", and I am not logged in 
		And I am on the home page
		When I try to access the edit event page for "edit_event_visitor_test"
		Then I should be on the user sign in page
		And I should see "You need to sign in or sign up before continuing."
		
	Scenario: A user that is logged in should not be able to edit another users event
		Given I am a user "edit_event_user", and I have an event "edit_event_visitor_user", and I am not logged in 
		And I am a user "testing123", and I have an event "testing999", and I am logged in
		And I am on the home page
		When I try to access the edit event page for "edit_event_visitor_user"
		Then I should be on the home page
		And I should see "Unable to process your request."
	
  Scenario: A user should be able to delete their events
  	Given I am a user "my_events_delete", and I have an event "my_events_delete_test", and I am logged in
  	And I am on the home page
  	When I click the "user_my_events" button
  	And I should see "my_events_delete_test"
		When I click the "Delete Event" button for "my_events_delete_test"
		Then I should see "Your event was successfully deleted."

	Scenario: Only events that are created by an approved user should be publicly viewable 
		Given I am a user "Unapproved_event_user", and I have an event "event not approved", and I am not logged in, and I am not approved for event creation
		And I am a user "approved_user", and I have an event "approved event", and I am not logged in 
		And I am on the home page
		When I visit the events index page
		Then I should see "approved event"
		And I should not see "event not approved"
	
	Scenario: You should only be able to access the show page for events that are created by approved users
		Given I am a user "Unapproved_event_user", and I have an event "un approved event", and I am not logged in, and I am not approved for event creation
		And I am a user "approved_event_user", and I have an event "approved event", and I am not logged in 
		And I am on the home page
		When I try to view the show page for the "un approved event" event
		Then I should be on the home page
		And I should see "Unable to process your request."
		When I try to view the show page for the "approved event" event
		Then I should see "Approved Event"
		And I should see "Created By: approved_event_user@cddn.com"
		
	Scenario: A user should be able to attend and un attend an event
		Given I am a user "attend_event_test_1", and I have an event "attend this event", and I am not logged in 
		And I am a user "attend_event_test_2" and I am logged in
		When I click the "all_events" button
		Then I should see "attend this event"
		When I click the "Attend Event" button 
		Then I should be on the show page for the "attend this event" event
		And I should see "You are now attending Attend this event"
		When I click the "user_my_events" button
		Then I should see "attend this event"
		When I click the "Un-attend Event" button
		Then I should be on the show page for the "attend this event" event
		And I should see "You are no longer attending Attend this event"
		

  Scenario:	Events should be searchable by programming language
  	Given I am a user "event_tag_search_1", and I have an event "fun event", and I have a ruby language tag, and I am logged in 
		And I am a user "event_tag_search_2", and I have an event "stupid event", and I have a smalltalk tag, and I am not logged in
  		And I am on the home page
		When I click the "all_events" button
  		Then I should see "fun event"
		And I should see "stupid event"
		When I fill in "language" with "ruby"
		And I click the "Search" button
		Then I should see "fun event"
		And I should not see "stupid event"
		When I fill in "language" with "smalltalk"
		And I click the "Search" button
		Then I should see "stupid event"
		And I should not see "fun event"
		
	Scenario: The events index page should only display upcoming events not past events
		Given I am a user "date_event_user", and I have an event "upcoming_event", and I am logged in
		And I am a user "date_event_user_2", and I have an event "past_event", that is a past event, that is not logged in
		When I click the "all_events" button
		Then I should see "upcoming_event"
		And I should not see "past_event"
		
	Scenario: Only past events should be viewable on the view past events page. 
		Given I am a user "date_event_user", and I have an event "upcoming_event", and I am logged in
		And I am a user "date_event_user_2", and I have an event "past_event", that is a past event, that is not logged in
		When I click the "past_events" button
		Then I should see "past_event"
		And I should not see "upcoming_event"
		
	Scenario: users that are not logged in should be able to view the past events page
		Given I am a user "date_event_user_2", and I have an event "past_event", that is a past event, that is not logged in
		And I am on the home page
		When I access the past events page
		Then I should be on the past events page
		And I should see "past_event"
		
	Scenario: users that are logged in should be able to access the past events page
		Given I am a user "create_events_failure_test" and I am logged in
		And I am a user "date_event_user_2", and I have an event "past_event", that is a past event, that is not logged in
		And I am on the home page
		When I access the past events page
		Then I should be on the past events page
		And I should see "past_event"
		
  	Scenario:	past events should be searchable by programming language
  		Given I am a user "event_tag_search_1", and I have a past event "fun event", and I have a ruby language tag, and I am logged in 
  		And I am a user "event_tag_search_2", and I have a past event "stupid event", and I have a smalltalk tag, and I am not logged in
  		And I am on the home page
  		When I click the "past_events" button
  		Then I should see "fun event"
  		And I should see "stupid event"
  		When I fill in "language" with "ruby"
  		And I click the "Search" button
  		Then I should see "fun event"
  		And I should not see "stupid event"
  		When I fill in "language" with "smalltalk"
  		And I click the "Search" button
  		Then I should see "stupid event"
  		And I should not see "fun event"
		
		
		
		
		