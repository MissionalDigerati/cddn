Feature: An admin should be able to login as well as well as delete and suspend users, however a visitor should not be able to create an admin account. Users should not be able to access admin functionality. An admin should also be able to delete events. They should also be able to approve users for the creation of events. 
	As an admin
	I want to be able to manage user accounts as well as login and out
	I do not want users or visitors to be able to access admin functionality
	
	Scenario: An admin should be able to login 
		Given I have an admin account "admin_login_test"
		When I visit the admin login page 
		When I fill in "Email" with "admin_login_test@cddn.com"
		And I fill in "Password" with "secret1"
		And I click the "Sign in" button
		Then I should be on the home page
		And I should see "Signed in as admin: admin_login_test@cddn.com"
		And I should see "Signed in successfully."

	Scenario: An admin should be able to log out 
		Given I have an admin account "admin_logout_test" and I am logged in
		And I should be on the home page
		And I should see "Signed in as admin: admin_logout_test@cddn.com"
		When I click the "Admin logout" button
		Then I should be on the home page
		And I should see "Signed out successfully."
		And I should not see "Signed in as admin: admin_logout_test@cddn.com"
		
	Scenario: An admin should be able to view the users index page
		Given I have an admin account "admin_index" and I am logged in
		And I have a user "admin_index_user"
		And I should be on the home page
		When I click the "Users index" link
		Then I should see "This is the users index"
		And I should see "admin_index_user"
		
	Scenario: A user that is logged in should not be able to access the admin index page
		Given I am a user "user_index_test" and I am logged in
		And I am on the home page
		When I try to access the admin user index page
		Then I should be on the admin sign in page
		And I should see "You need to sign in or sign up before continuing."
		
	Scenario: A visitor to the site should not be able to access the admin index page
		Given I am on the home page
		When I try to access the admin user index page
		Then I should be on the admin sign in page
		And I should see "You need to sign in or sign up before continuing."
		
	Scenario: An admin should be able to delete a user
		Given I have an admin account "admin_delete_user" and I am logged in
		And I have a user "user_to_be_deleted"
		And I should be on the home page
		When I click the "Users index" link
		Then I should see "This is the users index"
		And I should see "user_to_be_deleted"
		When I click the "Delete" button for "user_to_be_deleted"
		Then I should see "User has been deleted."
		
	Scenario: An admin should be able to suspend a user
	 	Given I have an admin account "admin_suspend_test" and I am logged in
	 	And I have a user "user_to_be_suspended"
	 	And I should be on the home page
	 	When I click the "Users index" link
	 	Then I should see "This is the users index"
	 	And I should see "user_to_be_suspended"
	 	When I click the "Suspend" button for "user_to_be_suspended"
	 	Then I should see "User has been suspended."
	
	Scenario: An admin should be able to suspend a user
		Given I have an admin account "admin_unsuspend_test" and I am logged in
		And I have a user "user_to_be_unsuspended" and they are suspended
		And I should be on the home page
		When I click the "Users index" link
		Then I should see "This is the users index"
		And I should see "user_to_be_unsuspended"
		When I click the "Un-suspend" button for "user_to_be_unsuspended"
		Then I should see "User has been un-suspended."
	
	Scenario: A user that is suspended should not be able to edit basic account info or access the dashboard
	 	Given I am a user "suspended_account_test" and I am logged in and I have a suspended account
		And I am on the home page
		When I click the "Home | Dashbaord" link
		Then I should be on the home page
		And I should see "Your account has been suspended please contact us for any additional information."
		When I click the "user_account_info_link" link
		Then I should be on the home page
		And I should see "Your account has been suspended please contact us for any additional information."
	
	Scenario: An admin should be able to view all events through the event index, and should be able to delete them at will
		Given I am a user "test1", and I have an event "admin index 1", and I am not logged in 
		And I am a user "test2", and I have an event "admin index 2", and I am not logged in 
		And I am a user "test3", and I have an event "admin index 3", and I am not logged in 
		And I have an admin account "Admin delete event test" and I am logged in
		And I am on the home page
		When I click the "Events index" button
		Then I should see "admin index 1"
		Then I should see "admin index 2"
		Then I should see "admin index 3"
		When I click the "Delete Event" button for "admin index 1"
		Then I should see "Event has been deleted."
		And I should see "admin index 2"
		And I should see "admin index 3"
		And I should not see "admin index 1"
		
	Scenario: A user that is logged in should not be able to access the admin event index page
		Given I am a user "admin_event_index" and I am logged in
		When I try to access the admin event index page
		Then I should be on the admin sign in page
		And I should see "You need to sign in or sign up before continuing."
		
 	Scenario: A visitor that is not logged in should not be able to access the admin event index page
 		Given I am on the home page
 		When I try to access the admin event index page
 		Then I should be on the admin sign in page
 		And I should see "You need to sign in or sign up before continuing."

 	Scenario: An admin should be able to approved a user for events, as well as view all users that have created events that are un approved for event creation
		Given I am a user "Approved_user", and I have an event "approved event", and I am not logged in
		And I am a user "Unapproved_user", and I have an event "not approved event", and I am not logged in, and I am not approved for event creation
 		And I have an admin account "admin_event_index" and I am logged in
		And I am on the home page
		When I click the "Users Event Approval" button
		And I should see "Unapproved_user"
		And I should not see "Approved_user"
		When I click the "Approve for events" button for "Unapproved_user"
		Then I should see "User has been approved to post events."
		And I should not see "Unapproved_user"
		
	Scenario: A user that is logged in should not be able to access the event user approval page
		Given I am a user "admin_event_user_access_test" and I am logged in
		When I try to access the event approval user page
		Then I should be on the admin sign in page
		And I should see "You need to sign in or sign up before continuing."
		
	Scenario: A visitor to the site that is not logged in should not be able to access the event suer approval page
		Given I am on the home page
		When I try to access the event approval user page
		Then I should be on the admin sign in page
		And I should see "You need to sign in or sign up before continuing."
		
	Scenario: An event should only be visible through the event index page if the admin as approved their events. Also their events should update once they have been approved
		Given I am a user "Unapproved_user_2", and I have an event "party asdfasdf", and I am not logged in, and I am not approved for event creation
		And I have an admin account "admin_event_index" and I am logged in
		And I am on the home page
		When I visit the users events index page
		Then I should not see "party asdfasf"
		When I click the "Users Event Approval" button
		Then I should see "Unapproved_user_2"
		When I click the "Approve for events" button for "Unapproved_user_2"
		Then I should see "User has been approved to post events."
		And I should not see "Unapproved_user_2"
		When I click the "Admin logout" button
		And I visit the users events index page
		Then I should see "party asdfasdf"
		 
	Scenario: An admin should be able to view events that have not been approved
		Given I am a user "Not an approved event user", and I have an event "unapproved event title", and I am not logged in, and I am not approved for event creation
		And I have an admin account "admin_event_show" and I am logged in
		And I am on the home page
		When I click the "Users Event Approval" button
		Then I should see "Not an approved event user"
		When I click the "unapproved event title" button
		Then I should be on the admin event show page for "unapproved event title"
		And I should see "unapproved event title"
		And I should see "This event was created by: Not an approved event user"
		
	Scenario: A user that is logged in should not be able to view events that have not been approved through the admin event show page
		Given I am a user "Sam", and I have an event "birthday", and I am not logged in, and I am not approved for event creation
		And I am a user "crab man" and I am logged in
		When I try to access the admin event show page for "birthday"
		Then I should be on the home page
		And I should see "Unable to process your request."
		
	Scenario: A visitor to the site that is not logged in should not be able to view events that have not been approved through the admin event show page
		Given I am a user "fred", and I have an event "tea party", and I am not logged in, and I am not approved for event creation
		And I am on the home page
		When I try to access the admin event show page for "tea party"
		Then I should be on the home page
		And I should see "Unable to process your request."
		