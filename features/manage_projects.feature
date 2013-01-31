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
		And I should see "Project Name"
		And I should be on the user dashboard for "create_project_test"
	
	Scenario: A user that is not logged in should not be able to access the create new project page
		Given I am on the home page
		When I try to access the new project form page
		Then I should be on the user sign in page
		And I should see "You need to sign in or sign up before continuing."
		
	Scenario: A user should be able to edit their project
		Given I am a user "edit_project_test" and I have a project "project name", and I am logged in
		And I am on the home page
		When I click the "Home | Dashboard" button
		Then I should see "project name"
		When I click the "Edit Project" button for "project name"
		And I fill in "Name" with "Edited_project_name"
		And I click the "Submit" button
		Then I should see "Your project has been successfully updated."
		And I should be on the user dashboard for "edit_project_test"
		
	Scenario: A visitor that is not logged in should not be able to access edit page for a users project
		Given I am a user "visitor_access_edit_project" and I have a project "visitor access project", and I am not logged in
		And I am on the home page
		When I try to access the edit project page for "visitor access project"
		Then I should be on the user sign in page
		And I should see "You need to sign in or sign up before continuing."
		
	Scenario: A user that is logged in should not be able to access the edit project page for another users project
		Given I am a user "user_access_edit_project" and I have a project "user access project edit", and I am not logged in
		And I am a user "trouble_maker" and I am logged in
		And I am on the home page
		When I try to access the edit project page for "user access project edit"
		Then I should be on the home page
		And I should see "Unable to process your request."
		
	Scenario: A visitor should be able to browse projects as well as view show pages for projects
		Given I am a user "visitor_project_index" and I have a project "visitor project index", and I am not logged in
		And I am on the home page
		When I visit the projects index
		Then I should see "visitor project index"
		When I click the "View Project" button
		And I should be on the project show page for "visitor project index"
		And I should see "visitor project index"
		
	Scenario: A user that is logged in should be able to view projects index page as well as the show pages
		Given I am a user "user_project_index" and I have a project "user project index", and I am not logged in
		And I am a user "visitor" and I am logged in
		When I visit the projects index
		Then I should see "user project index"
		When I click the "View Project" button
		And I should be on the project show page for "user project index"
		And I should see "user project index"
		
	Scenario: A user that as a project should be able to delete said project
		Given I am a user "delete_projects_test" and I have a project "project name", and I am logged in
		And I am on the home page
		When I click the "Home | Dashboard" button
		Then I should see "project name"
		When I click the "Delete Project" button for "project name"
		Then I should see "Your Project has been deleted."
		And I should not see "project name"
		
  Scenario: A user that is not project approved should not have their projects viewable via index or show
  	Given I am a user "un_approved_project_show" and I have a project "un-approved-project", and I am not approved for project creation
  	And I am on the home page
  	When I click the "Home | Dashboard" button
  	Then I should see "un-approved-project"
  	When I visit the projects index
  	Then I should not see "un-approved-project"
  	When I click the "Home | Dashboard" button
		And I click the "View Project" button
		Then I should see "Unable to process your request."
		
		
	Scenario: A user should be able to create a project with language tags
		Given I am a user "project_language_tags_create" and I am logged in
		And I am on the home page
		When I click the "user_new_project" link
		And I fill in "Name" with "Project Name"
		And I fill in "Description" with "This is the best project ever"
		And I fill in "License" with "Standard"
		And I fill in "Organization" with "CDDN"
		And I check the "Ruby" checkbox
		And I click the "Submit" button
		Then I should see "Your project has been successfully created."
		When I click the "View Project" button
		Then I should be on the project show page for "Project Name"
		And I should see "Ruby"
		
	Scenario: A user should be able to retain a projects languages through an update
		Given I am a user "project_language_tags_retain" and I am logged in
		And I am on the home page
		When I click the "user_new_project" link
		And I fill in "Name" with "Project Name"
		And I fill in "Description" with "This is the best project ever"
		And I fill in "License" with "Standard"
		And I fill in "Organization" with "CDDN"
		And I check the "Ruby" checkbox
		And I click the "Submit" button
		Then I should see "Your project has been successfully created."
		When I click the "View Project" button
		Then I should be on the project show page for "Project Name"
		And I should see "Ruby"
		When I click the "Home | Dashboard" button
		And I click the "Edit Project" button
		And I click the "Submit" button
		Then I should see "Your project has been successfully updated."
		When I click the "View Project" button
		Then I should be on the project show page for "Project Name"
		And I should see "Ruby"
		
  Scenario: A user should be able to remove a projects languages through an update
  	Given I am a user "project_language_tags_remove" and I am logged in
  	And I am on the home page
  	When I click the "user_new_project" link
  	And I fill in "Name" with "Project Name"
  	And I fill in "Description" with "This is the best project ever"
  	And I fill in "License" with "Standard"
  	And I fill in "Organization" with "CDDN"
  	And I check the "Ruby" checkbox
  	And I click the "Submit" button
  	Then I should see "Your project has been successfully created."
  	When I click the "View Project" button
  	Then I should be on the project show page for "Project Name"
  	And I should see "Ruby"
  	When I click the "Home | Dashboard" button
  	And I click the "Edit Project" button
		And I uncheck the "Ruby" checkbox
  	And I click the "Submit" button
  	Then I should see "Your project has been successfully updated."
  	When I click the "View Project" button
  	Then I should be on the project show page for "Project Name"
  	And I should not see "Ruby"
		
		
		
		