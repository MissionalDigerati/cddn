Feature: A user should be able to add social networking accounts and links to their user account, events, as well as projects
	As a user
	I want to be able to manage my social networking links
	I do not want users or visitors to be able to access the pages need to edit this information.
	
	Scenario: A user's networks should be visible, both on their dashboard as well as their show page
		Given I am a user "networking_user_show_test" and I have a network "facebook" I am logged in
		And I am on the home page
		When I click the "Home | Dashboard" button
		Then I should see "http://www.facebook.com"
		When I click the "view_profile" button 
		Then I should see "http://www.facebook.com"
		
	Scenario: A user's should be able to edit the their networks
		Given I am a user "networking_user_edit_test" and I have a network "github" I am logged in
		And I am on the home page
		When I click the "Home | Dashboard" link
		Then  I should be on the dashboard for "networking_user_edit_test"
		And I should see "http://www.github.com"
		When I click the "user_account_info_link" button
		And I select "Twitter" from "Service"
		And I fill in "Account name" with "Twitter"
		And I fill in "Account url" with "http://www.twitter.com"
		And I click the "Update" button
		Then I should see "Your account information has been updated."
		And I should be on the dashboard for "networking_user_edit_test"
		And I should see "http://www.twitter.com"
		And I should not see "http://www.github.com"

	Scenario: An event networks should be visible both on the dashbaord as well as on the show page
		Given I am a logged in user "event_network_show" and I have an event "event networking show" with a network "facebook" 
		When I try to view the show page for the "event networking show" event
		Then I should be on the show page for the "event networking show" event
		And I should see "http://www.facebook.com"
	
	Scenario: An event networks should be visible both on the dashbaord as well as on the show page
		Given I am a logged in user "event_network_edit" and I have an event "event networking edit" with a network "facebook" 
		And I am on the home page
		When I click the "user_my_events" link
		And I click the "Edit Event" button for "event networking edit"
		And I select "Facebook" from "Service"
		And I fill in "Account name" with "twitter"
		And I fill in "Account url" with "http://www.twitter.com"
		And I click the "Submit" button
		Then I should see "Your event was successfully updated."
		And I click the "View Event" button for "event networking edit"
		Then I should see "http://www.twitter.com"
		
	@javascript
		Scenario: A user should be able to add networks to their events
			Given I am a user "create_events_test" and I am logged in
			And I am on the new event page
			And I fill in "Title" with "Rails meet up"
			And I fill in "Address 1" with "123 fake street"
			And I fill in "City province" with "San Jose"
			And I fill in "State" with "California"
			And I fill in "Country" with "United States"
			And I fill in "Zip code" with "95123"
			And I fill in "Event date" with "1/01/2013"
			And I click the "Add Social Network" button
			And I select "GitHub" from "Service"
			And I fill in "Account name" with "github"
			And I fill in "Account url" with "http://www.GitHub.com"
			And I click the "Submit" button
			Then I should see "Your Event has been created!"
			When I click the "View Event" button
			Then I should see "http://www.GitHub.com"
			
	@javascript
		Scenario: A user's should be able to delete their social networks for their events
		Given I am a logged in user "event_network_remove" and I have an event "event networking remove" with a network "twitter" 
		And I try to view the show page for the "event networking remove" event
		And I should see "http://www.twitter.com"
		When I visit the my events page for "event_network_remove"  
		And I click the "Edit Event" button
		And I click the "remove_button" button
		And I click the "Submit" button
		Then I should see "Your event was successfully updated."
		And I click the "View Event" button
		Then I should not see "http://www.twitter.com"
			
	 
	@javascript
		Scenario: A user's should be able to delete their social networks
			Given I am a user "networking_user_delete_test" and I have a network "twitter" I am logged in
			And I am on the home page
			When I click the "Home | Dashboard" link
			Then I should be on the dashboard for "networking_user_delete_test"
			And I should see "http://www.twitter.com"
			When I click the "Edit account information" button
			And I click the "remove" button
			And I click the "Update" button
			Then I should see "Your account information has been updated."
			And I should be on the dashboard for "networking_user_delete_test"
			And I should not see "http://www.twitter.com"

	@javascript	
		Scenario: A user should be able to add social networks to their user account
			Given I am a user "networking_user_add_test" and I am logged in
			And I am on the home page
			When I click the "Home | Dashboard" link
			Then I should be on the dashboard for "networking_user_add_test"
			When I click the "Edit account information" button
			And I click the "Add Social Network" button
			And I select "Facebook" from "Service"
			And I fill in "Account name" with "facebook"
			And I fill in "Account url" with "http://www.facebook.com"
			And I click the "Update" button
			Then I should see "Your account information has been updated."
			And I should be on the dashboard for "networking_user_add_test"
			And I should see "http://www.facebook.com"
			
	@javascript
		Scenario: The application should reject a social network the attribute url is left blank
			Given I am a user "networking_user_reject_test" and I am logged in
			And I am on the home page
			When I click the "Home | Dashboard" link
			Then I should be on the dashboard for "networking_user_reject_test"
			When I click the "Edit account information" button
			And I click the "Add Social Network" button
			And I select "Facebook" from "Service"
			And I fill in "Account name" with "facebook"
			And I click the "Update" button
			Then I should see "Your account information has been updated."
			And I should be on the dashboard for "networking_user_reject_test"
			And I should not see "http://www.facebook.com"
			
			