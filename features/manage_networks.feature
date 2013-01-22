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

	@javascript
		Scenario: A user's should be able to delete
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
			
			