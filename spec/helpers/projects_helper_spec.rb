require 'spec_helper'


describe ProjectsHelper do
  describe "methods" do
    
    it "should return a link to the users profile when a record is provided" do
      user = FactoryGirl.create(:defaulted_user)
      project = FactoryGirl.create(:defaulted_project)
      memberships = FactoryGirl.create(:membership, user_id: user.id, project_id: project.id, role: "creator", status: "progress", creator_id: user.id)
      project_creator_link(project).should == "<a href=\"/users/1\">Fakeuser@test.com</a>"
    end
    
    it "should return the correct button/link depending on the type of user" do
      user = FactoryGirl.create(:defaulted_user)
      project = FactoryGirl.create(:defaulted_project)
      memberships = FactoryGirl.create(:membership, user_id: user.id, project_id: project.id, role: "creator", status: "progress", creator_id: user.id)
      #the creator of the project should not veiw anything
      join_project_request_button(project, user).should == ""
      
      #a user that is already a member of the project should recieve a leave project button
      project_member = FactoryGirl.create(:defaulted_user, email: "project_member@cddn.com")
      join_project_request_button(project, project_member).should == "<a href=\"/projects/1/join_project_request\" data-method=\"post\" rel=\"nofollow\">Request to Join Project</a>"
      
      # user that is not a member of the project should recieve a request to join project button
      non_member = FactoryGirl.create(:defaulted_user, email: "non_member@cddn.com")
      join_project_request_button(project, non_member).should == "<a href=\"/projects/1/join_project_request\" data-method=\"post\" rel=\"nofollow\">Request to Join Project</a>"
      
      # if a user is not logged in then nothing is displayed
    end
    
  end
end
