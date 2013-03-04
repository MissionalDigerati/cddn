Feature: A user should be able to add social networking accounts and links to their user account, events, as well as projects
	As a user
	I want to be able to manage my social networking links
	I do not want users or visitors to be able to access the pages need to edit this information.
	
	Scenario: A user's networks should be visible, both on their dashboard as well as their show page
		Given I am a user "networking_user_show_test" and I have a network "facebook" I am logged in
		And I am on the home page
		When I click the "Home | Dashboard" button
		Then I should see "facebook: facebook"
		When I click the "view_profile" button 
		Then I should see "facebook: facebook"
		
	Scenario: A user's should be able to edit the their networks
		Given I am a user "networking_user_edit_test" and I have a network "github" I am logged in
		And I am on the home page
		When I click the "Home | Dashboard" link
		Then  I should be on the dashboard for "networking_user_edit_test"
		And I should see "github: github"
		When I click the "user_account_info_link" button
		And I select "Twitter" from "Service"
		And I fill in "Account name" with "Twitter"
		And I fill in "Account url" with "http://www.twitter.com"
		And I click the "Update" button
		Then I should see "Your account information has been updated."
		And I should be on the dashboard for "networking_user_edit_test"
		And I should see "Twitter: Twitter"
		And I should not see "github: github"

	Scenario: An event networks should be visible both on the dashbaord as well as on the show page
		Given I am a logged in user "event_network_show" and I have an event "event networking show" with a network "facebook" 
		When I try to view the show page for the "event networking show" event
		Then I should be on the show page for the "event networking show" event
		And I should see "network_name: facebook"
	
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
		And I should be on the show page for the "event networking edit" event
		Then I should see "Facebook: twitter"
		
	@javascript
		Scenario: A user should be able to add networks to their events
			Given I am a user "create_events_test" and I am logged in
			And I am on the new event page
			And I fill in "Title" with "Rails meet up"
			And I fill in "Address 1" with "123 fake street"
			And I fill in "event_city_province" with "San Jose"
			And I fill in "Zip code" with "95123"
			And I fill in "event_event_dates_attributes_0_date_of_event" with current date
			And I fill in "event_event_dates_attributes_0_time_of_event" with current time
			And I click the "Add Social Network" button
			And I select "GitHub" from "Service"
			And I fill in "Account name" with "github"
			And I fill in "Account url" with "http://www.GitHub.com"
			And I click the "Submit" button
			Then I should see "Your Event has been created!"
			And I should be on the show page for the "Rails meet up" event
			Then I should see "GitHub: github"
			
	@javascript
		Scenario: A user's should be able to delete their social networks for their events
		Given I am a logged in user "event_network_remove" and I have an event "event networking remove" with a network "twitter" 
		And I try to view the show page for the "event networking remove" event
		And I should see "network_name: twitter"
		When I visit the my events page for "event_network_remove"  
		And I click the "Edit Event" button
		And I click the "remove_networks_button" button
		And I click the "Submit" button
		Then I should see "Your event was successfully updated."
		And I should be on the show page for the "event networking remove" event
		Then I should not see "network_name: twitter"
			
	 
	@javascript
		Scenario: A user's should be able to delete their social networks
			Given I am a user "networking_user_delete_test" and I have a network "twitter" I am logged in
			And I am on the home page
			When I click the "Home | Dashboard" link
			Then I should be on the dashboard for "networking_user_delete_test"
			And I should see "twitter: twitter"
			When I click the "edit_account_details" button
			And I click the "remove" button
			And I click the "Update" button
			Then I should see "Your account information has been updated."
			And I should be on the dashboard for "networking_user_delete_test"
			And I should not see "twitter: twitter"

	@javascript	
		Scenario: A user should be able to add social networks to their user account
			Given I am a user "networking_user_add_test" and I am logged in
			And I am on the home page
			When I click the "Home | Dashboard" link
			Then I should be on the dashboard for "networking_user_add_test"
			When I click the "edit_account_details" button
			And I click the "Add Social Network" button
			And I select "Facebook" from "Service"
			And I fill in "Account name" with "facebook"
			And I fill in "Account url" with "http://www.facebook.com"
			And I click the "Update" button
			Then I should see "Your account information has been updated."
			And I should be on the dashboard for "networking_user_add_test"
			And I should see "Facebook: facebook"
			
	@javascript
		Scenario: The application should reject a social network the attribute url is left blank
			Given I am a user "networking_user_reject_test" and I am logged in
			And I am on the home page
			When I click the "Home | Dashboard" link
			Then I should be on the dashboard for "networking_user_reject_test"
			When I click the "edit_account_details" button
			And I click the "Add Social Network" button
			And I select "Facebook" from "Service"
			And I fill in "Account name" with "facebook"
			And I click the "Update" button
			Then I should see "Your account information has been updated."
			And I should be on the dashboard for "networking_user_reject_test"
			And I should not see "http://www.facebook.com"
			
	 @javascript
	 	Scenario: A user should be able to add networks to their projects and show be viewable on the project show page
	 		Given I am a user "create_projects_networks" and I am logged in
	 		And I am on the new project page
	 		And I fill in "Name" with "create projects network"
	 		And I fill in "Description" with "this is a project description"
	 		And I fill in "License" with "Standard"
	 		And I fill in "Organization" with "CDDN"
	 		And I click the "Add Social Network" button
	 		And I select "GitHub" from "Service"
	 		And I fill in "Account name" with "github"
	 		And I fill in "Account url" with "http://www.GitHub.com"
	 		And I click the "Submit" button
	 		Then I should see "Your project has been successfully created."
			And I should be on the project show page for "create projects network"
	 		Then I should see "GitHub: github"
	
	 @javascript
	   Scenario: A user should be able to edit networks associated with their projects
	   	Given I am a user "edit_projects_networks" and I am logged in
	   	And I am on the new project page
	   	And I fill in "Name" with "edit projects network"
	   	And I fill in "Description" with "this is a project description"
	   	And I fill in "License" with "Standard"
	   	And I fill in "Organization" with "CDDN"
	   	And I click the "Add Social Network" button
	   	And I select "GitHub" from "Service"
	   	And I fill in "Account name" with "github"
	   	And I fill in "Account url" with "http://www.GitHub.com"
	   	And I click the "Submit" button
	   	Then I should see "Your project has been successfully created."
	 	 	And I should be on the project show page for "edit projects network"
	  	And I should see "GitHub: github"
			When I visit the my project page for "edit_projects_networks"
			And I click the "Edit Project" button
			And I select "Twitter" from "Service"
			And I fill in "Account name" with "Twitter"
	   	And I fill in "Account url" with "http://www.Twitter.com"
			And I click the "Submit" button
			Then I should see "Your project has been successfully updated."
			And I should be on the project show page for "edit projects network"
			And I should see "Twitter: Twitter"
			And I should not see "GitHub: github"
			
	 @javascript
	    Scenario: A user should be able to delete networks associated with their projects
	    Given I am a user "delete_projects_networks" and I am logged in
	    And I am on the new project page
	    And I fill in "Name" with "delete projects network"
	    And I fill in "Description" with "this is a project description"
	    And I fill in "License" with "Standard"
	    And I fill in "Organization" with "CDDN"
	    And I click the "Add Social Network" button
	    And I select "GitHub" from "Service"
	    And I fill in "Account name" with "github"
	    And I fill in "Account url" with "http://www.GitHub.com"
	    And I click the "Submit" button
	    Then I should see "Your project has been successfully created."
	  	And I should be on the project show page for "delete projects network"
	   	And I should see "GitHub: github"
	 		When I visit the my project page for "delete_projects_networks"
	 		And I click the "Edit Project" button
	 		And I click the "remove" button
	 		And I click the "Submit" button
	 		Then I should see "Your project has been successfully updated."
	 		And I should be on the project show page for "delete projects network"
	 		And I should not see "GitHub: github"
			
  @javascript
      Scenario: A network for a project should not be created if (rejected) if the url is not provided
      Given I am a user "reject_projects_networks" and I am logged in
      And I am on the new project page
      And I fill in "Name" with "reject projects network"
      And I fill in "Description" with "this is a project description"
      And I fill in "License" with "Standard"
      And I fill in "Organization" with "CDDN"
      And I click the "Add Social Network" button
      And I select "GitHub" from "Service"
      And I fill in "Account name" with "github"
      And I click the "Submit" button
      Then I should see "Your project has been successfully created."
    	And I should be on the project show page for "reject projects network"
     	And I should not see "GitHub: github"
			And I should not see "github"

  