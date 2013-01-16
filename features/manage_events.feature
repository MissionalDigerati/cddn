Feature: A logged in user should be able to create events as state they are attending them
	As a user
	I should be able to create events as well as manage them, as well as state my role in them. 
	I do not want users or visitors to be able to access the creation or editing functionality of events. However they can mark that they are attending them
	
	Scenario: A user should be able to create events 
		Given I am a user "create_events_test" and I am logged in
		And I am on the home page
		When I click the "New Event" link
		Then I should be on the new event page
		And I fill in "Title" with "Rails meet up"
		And I fill in "Address 1" with "123 fake street"
		And I fill in "City province" with "San Jose"
		And I fill in "State" with "California"
		And I fill in "Country" with "United States"
		And I fill in "Zip code" with "95123"
		And I click the "Submit" button
		Then I should see "Your Event has been created!"
		
	Scenario: A user should not be able to create events if all the the required attributes are not present
		Given I am a user "create_events_failure_test" and I am logged in
		And I am on the home page
		When I click the "New Event" link
		Then I should be on the new event page
		When I click the "Submit" button
		Then I should see "Title can't be blank, Address 1 can't be blank, City province can't be blank, State can't be blank, Country can't be blank, and Zip code can't be blank"
		
	Scenario: A visitor that is not logged in should not be able to access the the new events form page
		Given I am on the home page
		When I try to access the new event page
		Then I should be on the user sign in page
		And I should see "You need to sign in or sign up before continuing."
		
	Scenario: A user should be able to create an event and view it on the events index page
		Given I am a user "events_index_test" and I am logged in
		And I have an event "Testing event index"
		And I am on the home page
		When I click the "All Events" link
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
		When I click the "All Events" button
		Then I should be on the events index page
		And I should see "show_testing_self_test"
		When I click the "View Event" button
		Then I should see "This event was created by: event_show_test@cddn.com"
		
	Scenario: A visitor that is not logged in should be able to view a show page for an event
		Given I am a user "event_show_test_for_visitor", and I have an event "show_testing_visitor_test", and I am not logged in 
		And I am on the home page
		When I visit the events index page
		Then I should see "show_testing_visitor_test"
		When I click the "View Event" button
		Then I should see "This event was created by: event_show_test_for_visitor@cddn.com"
		
	Scenario: A user should be able to view their events on the my index page
		Given I am a user "my_events_show", and I have an event "my_events_show_test", and I am logged in
		And I am on the home page
		When I click the "My Events" button
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
		When I click the "My Events" button
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
  	When I click the "My Events" button
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
		And I should see "Unable to locate event."
		When I try to view the show page for the "approved event" event
		Then I should see "approved event"
		And I should see "This event was created by: approved_event_user"
		
	
	
	