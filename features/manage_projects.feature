Feature: A user should be able to create update delete and join projects, as well as approve users for projects. Users not logged in should not be able to do so. Nor should users or visitors should be able to access the private information that a user sees when they are logged in.
	As a user
	I want to be able to manage my projects links
	I do not want users or visitors to be able to access the pages need to edit this information.
	
	Scenario: A user should be able to create a project
		Given I am a user "create_project_test" and I am logged in
		And I am on the home page
		When I click the "user_new_project" link
		Then I should be on the new project page
		And I fill in "Name" with "Project Name"
		And I fill in "Description" with "This is the best project ever"
		And I fill in "License" with "Standard"
		And I fill in "Organization" with "CDDN"
		And I click the "Submit" button
		Then I should see "Your project has been successfully created."
		And I should be on the project show page for "Project Name"
		And I should see "Project Name"
		And I should see "This is the best project ever"
		And I should see "Standard"
		And I should see "CDDN"

			
