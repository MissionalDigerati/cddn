Feature: A user that is logged in should be able to join projects so long as they are accepting requests, the creator of the project should be able to view and approve or deny all applicants.
	As a user
	I should be able to send a request to join a project.
	I should be able to approve or deny their requests and view who is on my team via the project show page
	
	Scenario: A user should be able to request to join events
		Given I am a user "project_creator" and I have a project "accepting_requests_project", and I am not logged in
		And I am a user "request_project_user" and I am logged in
		And I am on the home page
		When I visit the projects index
		Then I should see "accepting_requests_project"
		When I click the "View Project" button
		And I should be on the project show page for "accepting_requests_project"
		And I should see "Project Creator: project_creator"
		When I click the "Request to Join Project" button
		Then I should be on the project show page for "accepting_requests_project"
		And I should see "Request to join project has been sent."
		
	Scenario: A member of a project should be able to cease their membership from a project (leaving project)
		Given I am a user "project_creator" and I have a project "leaving_project", and I am not logged in
		And I am a user "leaving_project_user", that is a member of the project "leaving_project", and I am logged in
		And I am on the home page
		When I visit the projects index
		Then I should see "leaving_project"
		When I click the "View Project" button
		And I should be on the project show page for "leaving_project"
		And I should see "Project Creator: project_creator"
		And I should see "leaving_project_user"
		When I click the "Leave Project" button
		Then I should be on the project show page for "leaving_project"
		And I should see "You have left the project."
		And I should see "Request to Join Project"
		