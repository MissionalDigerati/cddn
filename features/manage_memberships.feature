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
		And I should see "Project Creator: Project_creator"
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
		And I should see "Project Creator: Project_creator"
		And I should see "leaving_project_user"
		When I click the "Leave Project" button
		Then I should be on the project show page for "leaving_project"
		And I should see "You have left the project."
		And I should see "Request to Join Project"
		
	Scenario: A creator of a project should be able to approve users that have requested to be members of projects
		Given I am a user "approve_requests" and I have a project "approve_requests_projects", and I am logged in 
		And I am a user "needing_approval", that is requesting to be a member of the project "approve_requests_projects", and I am logged not in
		And I am on the home page
		When I click the "Home | Dashboard" button
		Then I should see "Needing_approval"
		When I click the "Approve" button
		Then I should see "User has been approved"
		And I should not see "needing_approval"
		When I click the "user_my_projects" button
		And I click the "View Project" button
		Then I should see "Needing_approval"
	
	Scenario: A creator of a project should be able to deny users that have requested to be members of projects
		Given I am a user "project_creator" and I have a project "deny_requests_projects", and I am logged in 
		And I am a user "needing_denial", that is requesting to be a member of the project "deny_requests_projects", and I am logged not in
		And I am on the home page
		When I click the "Home | Dashboard" button
		Then I should see "Needing_denial"
		When I click the "Deny" button
		Then I should see "User has been denied"
		And I should not see "needing_denial"
		When I click the "user_my_projects" button
		And I click the "View Project" button
		Then I should not see "needing_denial"
		
	Scenario: A user should not be able to request to join a project that is not accepting requests
		Given I am a user "project_creator" and I have a project "not_accepting_requests", that is not accepting requests, and I am not logged in
		And I am a user "request_project_user" and I am logged in
		When I visit the projects index
		Then I should see "not_accepting_requests"
		When I click the "View Project" button
		And I should be on the project show page for "not_accepting_requests"
		And I should not see "Request to Join Project"
		
	Scenario: A user that is a member of a project should be able to leave the project even if they project is no longer accepting requests
		Given I am a user "project_creator" and I have a project "not_accepting_requests", that is not accepting requests, and I am not logged in
		And I am a user "leaving_project_user", that is a member of the project "not_accepting_requests", and I am logged in
		When I visit the projects index
		Then I should see "not_accepting_requests"
		When I click the "View Project" button
		And I should be on the project show page for "not_accepting_requests"
		When I click the "Leave Project" button
		Then I should be on the project show page for "not_accepting_requests"
		And I should see "You have left the project."
		And I should not see "Request to Join Project"
		
		
		