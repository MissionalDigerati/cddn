Feature: A user should be able to manage their account and have certain pages and information only accessible to them
	As a user
	I want to bel able to manage and create an account 
	
	Scenario: A user should be able to create an account
		Given I am on the home page
		When I click the "Sign up" link
		Then I should be on the user sign up page
		When I fill in "Email" with "user@test.com"
		And I fill in "user_password" with "secret1"
		And I fill in "user_password_confirmation" with "secret1"
		And I click the "Sign up now!" button
		Then I should be on the home page
		And I should see "Welcome! You have signed up successfully."
		And I should see "Logged in as user@test.com"
		
	Scenario: A user should not be able to login with invalid credentials
		Given I am on the home page
		When I click the "Login" link
		Then I should be on the user sign in page
		When I fill in "Email" with "invalid"
		And I fill in "Password" with "stupid3432"
		And I click the "Sign in" button
		Then I should be on the user sign in page
		And I should see "Invalid email or password."
		
	Scenario: A user should be able to login to their account
		Given I have a user "login_test"
		And I am on the home page
		When I click the "Login" link
		Then I should be on the user sign in page
		When I fill in "Email" with "login_test@example.com"
		And I fill in "Password" with "testing123"
		And I click the "Sign in" button
		Then I should be on the home page
		And I should see "Signed in successfully."
		And I should see "Logged in as login_test@example.com"
		
	Scenario: A user should be able to edit their account info
		Given I am a user "edit_account_info" and I am logged in
		And I am on the home page
		When I click the "Home | Dashbaord" link
		Then I should see "dashboard"
		And I should see "edit_account_info@example.com"
		When I click the "Edit account info" link
		And I fill in "Email" with "updated_email@test.com"
		And I fill in "Current password" with "secretpassword1000"
		And I click the "Update" button
		Then I should see "You updated your account successfully."
		
	Scenario: A users brag page should be viewable publicly or by other members
		Given I have a user "brag_test"
		When I visit the brag page for "brag_test"
		Then I should see "brag_test nickname"
		
	Scenario: A logged in user should be able to access only their dashboard
		Given I have a user "Fred"
		And I am a user "authentication_test" and I am logged in
		When I click the "Home | Dashbaord" link
		Then I should see "authentication_test"
		And I should not see "Fred"
		Then I visit the user dash board for "Fred"
		And I should not see "Fred"
		And I should see "authentication_test"
		
	Scenario: A user that is not logged in should not be able to access anyone's dashboard
		Given I have a user "dashboard_test"
		And I am on the home page
		When I visit the user dash board for "dashboard_test"
		Then I should be on the user sign in page
		And I should see "You need to sign in or sign up before continuing."
		# And I should still be on the user dash board for "authentication_test"
		
		#should not be able to view others dashboard