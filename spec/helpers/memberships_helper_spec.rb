require 'spec_helper'

describe MembershipsHelper do
	describe "methods" do
		it "should return a link to approve the approprate user for a membership" do
		  user = FactoryGirl.create(:defaulted_user)
		  project = FactoryGirl.create(:defaulted_project)
		  membership = FactoryGirl.create(:membership, user_id: user.id, project_id: project.id, status: "active", role: "creator", creator_id: user.id)
		  user_2 = FactoryGirl.create(:defaulted_user, nickname: "testing", email: "123fake@test.com")
		  membership_2 = FactoryGirl.create(:membership, user_id: user_2.id, project_id: project.id, status: "pending", role: "member", creator_id: user.id)
		  approve_mem_button(membership_2).should =="<a href=\"/memberships/2/project_update_memberships?mem_update=approved\" data-method=\"put\" rel=\"nofollow\">Approve</a>"
		end

		it "should return a link to deny the approprate user for a membership" do
		  user = FactoryGirl.create(:defaulted_user)
		  project = FactoryGirl.create(:defaulted_project)
		  membership = FactoryGirl.create(:membership, user_id: user.id, project_id: project.id, status: "active", role: "creator", creator_id: user.id)
		  user_2 = FactoryGirl.create(:defaulted_user, nickname: "testing", email: "123fake@test.com")
		  membership_2 = FactoryGirl.create(:membership, user_id: user_2.id, project_id: project.id, status: "pending", role: "member", creator_id: user.id)
		  deny_mem_button(membership_2).should =="<a href=\"/memberships/2/project_update_memberships?mem_update=denied\" data-method=\"put\" rel=\"nofollow\">Deny</a>"
		end
	end
end