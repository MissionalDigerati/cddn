require 'spec_helper'


describe ProjectsHelper do
  describe "methods" do
    
    it "should return a link to the users profile when a record is provided" do
      user = FactoryGirl.create(:defaulted_user)
      project = FactoryGirl.create(:defaulted_project)
      memberships = FactoryGirl.create(:membership, user_id: user.id, project_id: project.id, role: "creator", status: "progress")
      project_creator_link(project).should == "<a href=\"/users/1\">fakeuser@test.com</a>"
    end
    
  end
end
