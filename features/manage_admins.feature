Feature: An admin should be able to login as well as well as delete and suspend users, however a visitor should not be able to create an admin account
	As an admin
	I want to be able to manage user accounts as well as login and out
	
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