require 'spec_helper'

describe Membership do
  describe "validations" do
    
    it "should create a a valid membership record." do
      user = FactoryGirl.create(:defaulted_user)
      project = FactoryGirl.create(:defaulted_project)
      FactoryGirl.create(:membership, user_id: user.id, project_id: project.id, role: "creator", status: "progress").should be_valid
    end
    
    
    it "should not create a a valid membership record if any necissary information is omitted." do
      user = FactoryGirl.create(:defaulted_user)
      FactoryGirl.build(:membership, user_id: user.id, project_id: nil, role: "creator", status: "progress").should_not be_valid
    end
    
    it "should delete the membership records if the project is destoryed" do
      user = FactoryGirl.create(:defaulted_user)
      project = FactoryGirl.create(:defaulted_project)
      membership = FactoryGirl.create(:membership, user_id: user.id, project_id: project.id, role: "creator", status: "progress")
      Membership.all.length.should == 1
      project.destroy
      Membership.all.length.should == 0 
    end
    
  end
  
  describe "methods" do
    
    it "should create a valid membership for the creator of a project if all the params are provided" do
      user = FactoryGirl.create(:defaulted_user)
      project = FactoryGirl.create(:defaulted_project) 
      Membership.membership_creation(user.id, project)
      membership_created = Membership.first
      membership_created.user_id.should == user.id
      membership_created.project_id.should == project.id
      membership_created.role.should == "creator"
      membership_created.status.should == "active"
      membership_created.creator_id.should == user.id
    end
    
    #please note that the creator trys to join project, however after trying, only one membership record remains, the one that states they created
    # the project, no new one is created. 
    it "should not let a creator of a project join as a member" do
      user = FactoryGirl.create(:defaulted_user)
      project = FactoryGirl.create(:defaulted_project) 
      membership_creator = Membership.membership_creation(user.id, project)
      Membership.join_project_request(project, user)
      Membership.all.length.should == 1
      Membership.first.should == membership_creator
    end
    
    it "should let a user that is not the creator of a project join a project" do
      user_created = FactoryGirl.create(:defaulted_user)
      project = FactoryGirl.create(:defaulted_project) 
      membership_creator = Membership.membership_creation(user_created.id, project)
      user_member = FactoryGirl.create(:defaulted_user, email: "user@asfasdf.com")
      user_membership = Membership.join_project_request(project, user_member)
      Membership.all.length.should == 2
      Membership.last.should == user_membership
      user_membership.creator_id.should == user_created.id
    end
    
    it "should not let the creator of the project leave the project" do
      user_created = FactoryGirl.create(:defaulted_user)
      project = FactoryGirl.create(:defaulted_project) 
      Membership.membership_creation(user_created.id, project)
      Membership.leave_project(project, user_created)
      Membership.all.length.should == 1
    end
    
    it "should not let a member of a project join a second time" do 
      user_created = FactoryGirl.create(:defaulted_user)
      project = FactoryGirl.create(:defaulted_project) 
      membership_creator = Membership.membership_creation(user_created.id, project)
      user_member = FactoryGirl.create(:defaulted_user, email: "user@asfasdf.com")
      user_membership = Membership.join_project_request(project, user_member)
      user_membership = Membership.join_project_request(project, user_member)
      Membership.all.length.should == 2
    end
    
    it "should let a member of the project leave the project, meaning the membership record is destoryed" do
      user_created = FactoryGirl.create(:defaulted_user)
      project = FactoryGirl.create(:defaulted_project) 
      user_member = FactoryGirl.create(:defaulted_user, email: "otherUser@cddn.com")
      creator_membership = Membership.membership_creation(user_created.id, project)
      member_membership = Membership.create(user_id: user_member.id, status: "active", project_id: project.id, role: "member", creator_id: user_created.id)
      Membership.all.length.should == 2
      Membership.leave_project(project, user_member)
      Membership.all.length.should == 1
      Membership.all.first.should == creator_membership
    end
    
    it "should update a membership with the params inputted by the controller/view" do
      project = FactoryGirl.create(:defaulted_project) 
      membership = FactoryGirl.create(:membership, user_id: 1, project_id: project.id, role: "member", status: "pending")
      Membership.membership_approve_deny(membership, "approved")
      membership.status.should == "approved"
      
      Membership.membership_approve_deny(membership, "denied")
      membership.status.should == "denied"
    end
  end
  
end
