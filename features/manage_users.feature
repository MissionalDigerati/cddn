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
		And I should see "Logged in as user@test.com"
		
		# should be able to view own dashboard 
		# should be able to view brag page 
		# 		should be able to view others brag page
		# 		should not be able to view others dashboard