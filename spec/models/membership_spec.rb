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
end
