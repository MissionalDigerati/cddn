Feature: A user should be able to create update delete and join projects, as well as approve users for projects. Users not logged in should not be able to do so. Nor should users or visitors should be able to access the private information that a user sees when they are logged in.
	As a user
	I want to be able to manage my projects links
	I do not want users or visitors to be able to access the pages need to edit this information.
	
	Scenario: A user should be able to create a project, as an project approved user, it will redirect them to the project show page
		Given I am a user "create_project_test" and I am logged in
		And I am on the home page
		When I click the "user_new_project" link
		Then I should be on the new project page
		And I fill in "Name" with "Project Name"
		And I fill in "Description" with "This is the best project ever"
		And I fill in "License name" with "Test Programming License"
		And I fill in "Organization" with "CDDN"
		And I click the "Submit" button
		Then I should see "Your project has been successfully created."
		And I should see "Project Name"
		And I should be on the project show page for "Project Name"

	Scenario: A user that does not select a correct programming license should recieve a special message
		Given I am a user "special_project_message" and I am logged in
		And I am on the home page
		When I click the "user_new_project" link
		Then I should be on the new project page
		And I fill in "Name" with "Project Name"
		And I fill in "Description" with "This is the best project ever"
		And I fill in "License name" with ""
		And I fill in "Organization" with "CDDN"
		And I click the "Submit" button
		Then I should see "License is required, if you do not have one, please select 'No License Specified'."
		
	Scenario: A user that is not approved for project creation should receive a special message and redirection for product creation
		Given I am a user not approved for project creation "unapproved_project_user" and I am logged in 
		And I am on the home page
		When I click the "user_new_project" link
		Then I should be on the new project page
		And I fill in "Name" with "Project Name"
		And I fill in "Description" with "This is the best project ever"
		And I fill in "License name" with "Test Programming License"
		And I fill in "Organization" with "CDDN"
		And I click the "Submit" button
		Then I should see "Your Project has been submitted for approval, and will not be visible until approved."
		And I should be on the my project page for "unapproved_project_user"
		
	Scenario: A user that is not logged in should not be able to access the create new project page
		Given I am on the home page
		When I try to access the new project form page
		Then I should be on the user sign in page
		And I should see "You need to sign in or sign up before continuing."
		
	Scenario: A user should be able to edit their project, and as approved users should be redirected to the project show page.
		Given I am a user "edit_project_test" and I have a project "project name", and I am logged in
		And I am on the home page
		When I click the "user_my_projects" button
		Then I should see "project name"
		When I click the "Edit Project" button for "project name"
		And I fill in "Name" with "Edited_project_name"
		And I click the "Submit" button
		Then I should see "Your project has been successfully updated."
		And I should be on the project show page for "Edited_project_name"
		
	Scenario: As an unapproved user editing their project, I should see a message stating it is still not viewable, and should be directed to the my projects page
		Given I am a user "un_approved_project_update" and I have a project "un-approved-project", and I am not approved for project creation
		And I am on the home page
		When I click the "user_my_projects" button
		Then I should see "un-approved-project"
		When I click the "Edit Project" button for "un-approved-project"
		And I fill in "Name" with "Edited_project_name"
		And I click the "Submit" button
		Then I should see "Your Project has been update, and is still pending approval, and will not be visible until approved."
		And I should be on the my project page for "un_approved_project_update"
		
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
		Then I should see "Visitor project index"
		When I click the "View Project" button
		And I should be on the project show page for "visitor project index"
		And I should see "Visitor_project_index@cddn.com"
		
	Scenario: A user that is logged in should be able to view projects index page as well as the show pages
		Given I am a user "user_project_index" and I have a project "user project index", and I am not logged in
		And I am a user "visitor" and I am logged in
		When I visit the projects index
		Then I should see "User project index"
		When I click the "View Project" button
		And I should be on the project show page for "user project index"
		And I should see "User_project_index@cddn.com"
		
	Scenario: A user that as a project should be able to delete said project
		Given I am a user "delete_projects_test" and I have a project "project name", and I am logged in
		And I am on the home page
		When I click the "user_my_projects" button
		Then I should see "project name"
		When I click the "Delete Project" button for "project name"
		Then I should see "Your Project has been deleted."
		And I should not see "project name"
		
  Scenario: A user that is not project approved should not have their projects viewable via index or show
  	Given I am a user "un_approved_project_show" and I have a project "un-approved-project", and I am not approved for project creation
  	And I am on the home page
  	When I click the "user_my_projects" button
  	Then I should see "un-approved-project"
  	When I visit the projects index
  	Then I should not see "un-approved-project"
  	When I click the "user_my_projects" button
		And I click the "View Project" button
		Then I should see "Unable to process your request."
		
	Scenario: A user should be able to search for projects based on if they're accepting requests or not
		Given I am a user "accepting_requests" and I have a project "accepting_requests_project", and I am not logged in
		And I am a user "not_accepting_requests" and I have a project "not_accepting_requests_project", that is not accepting requests, and I am not logged in
		And I am on the home page
		When I visit the projects index
		Then I should see "Accepting_requests_project"
		And I should see "Not_accepting_requests_project"
		When I check the "open_projects" checkbox
		And I click the "Search" button
		Then I should see "Accepting_requests_project"
		And I should not see "Not_accepting_requests_project"
		
	Scenario: A user should be able to search for projects based on language tags
		Given I am a user "project_no_lang" and I have a project "project_no_lang_project", and I am not logged in
		And I am a user "project_with_lang" and I have a project "project_with_lang_project", that has a language tag, and I am not logged in
		And I am on the home page
		When I visit the projects index
		Then I should see "Project_no_lang_project"
		And I should see "Project_with_lang_project"
		When I fill in "language" with "Ruby"
		And I click the "Search" button
		Then I should see "Project_with_lang_project"
		And I should not see "Project_no_lang_project"
		
	Scenario: A user should be able to filter by both programming language as well as projects accepting requests
		Given I am a user "no_tag_accepting" and I have a project "no_tag_accepting_project", and I am not logged in
		And I am a user "no_tag_not_accepting" and I have a project "no_tag_not_accepting_project", that is not accepting requests, and I am not logged in
		And I am a user "project_with_lang_accepting" and I have a project "project_with_lang_accepting_project", that has a language tag, and I am not logged in
		And I am a user "project_with_lang_not_accepting" and I have a project "project_with_lang_not_accepting_project", that has a language tag, that is not accepting requests, and I am not logged in
		And I am on the home page
		When I visit the projects index
		Then I should see "No_tag_accepting_project"
		And I should see "No_tag_not_accepting_project"
		And I should see "Project_with_lang_accepting_project"
		And I should see "Project_with_lang_not_accepting_project"
		When I check the "open_projects" checkbox
		And I fill in "language" with "Ruby"
		And I click the "Search" button
		Then I should see "Project_with_lang_accepting_project"
		And I should not see "No_tag_accepting_project"
		And I should not see "No_tag_not_accepting_project"
		And I should not see "Nroject_with_lang_not_accepting_project"
		
	Scenario: A user that is logged in should be able to view their my projects page
		Given I am a user "user_one" and I have a project "other_project", and I am not logged in
		And I am a user "user_two" and I have a project "my_project", and I am logged in
		And "user_two" is a "approved" member of the "other_project"
		And I am on the home page
		When I click the "user_my_projects" button
		Then I should see "other_project"
		And I should see "my_project"
		
	Scenario: A user that is logged in should not be able to view another users my project page
		Given I am a user "user_one" and I have a project "other_project", and I am not logged in
		And I am a user "user_two" and I have a project "my_project", and I am logged in
		And I am on the home page
		When I click the "user_my_projects" button
		Then I should be on the my project page for "user_two"
		Then I should see "my_project"
		And I should not see "other_project"
		When I try to access the my project page for "user_one"
		And I should see "my_project"
		And I should not see "other_project"
	
	Scenario: A user that is not logged in should not be able to access the my project page
		Given I am a user "user_one" and I have a project "my_project", and I am not logged in
		And I am on the home page
		When I try to access the my project page for "user_one"
		Then I should be on the user sign in page
		And I should see "You need to sign in or sign up before continuing."