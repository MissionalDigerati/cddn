Feature: An admin should be able to login as well as well as delete and suspend users, however a visitor should not be able to create an admin account. Users should not be able to access admin functionality
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

	Scenario: An admin should be abel to log out 
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
	
	
	Scenario: A user that is suspended should not be able to edit basic account info or access the dashboard
	 	Given I am a user "suspended_account_test" and I am logged in and I have a suspended account
		And I am on the home page
		When I click the "Home | Dashbaord" link
		Then I should be on the home page
		And I should see "Your account has been suspended please contact us for any additional information."
		When I click the "Edit basic account info" link
		Then I should be on the home page
		And I should see "Your account has been suspended please contact us for any additional information."
		