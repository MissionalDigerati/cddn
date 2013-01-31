require 'spec_helper'

describe Project do
  describe "validations" do
    
    it "should create a valid project" do
      FactoryGirl.create(:defaulted_project).should be_valid
    end
   
    it "shold not create a valid project if all the approprate information is not provided" do
      FactoryGirl.build(:defaulted_project, name: nil).should_not be_valid
    end
    
    it "should delete the related networks of the project is destroyed" do
      social_media = FactoryGirl.create(:social_medium, service: "facebook")
      user = FactoryGirl.create(:defaulted_user)
      project = FactoryGirl.create(:defaulted_project)
      membership = FactoryGirl.create(:membership, user_id: user.id, project_id: project.id, role: "creator", status: "progress")
      network = project.networks.create(social_media_id: social_media.id, account_name: "filler", account_url: "filler")
      Network.all.length.should == 1
      project.destroy
      Network.all.length.should == 0
    end
    
    it "should delete the programmigns records if the project that owns them is destroyed" do
      language = FactoryGirl.create(:defaulted_programming_language)
      project = FactoryGirl.create(:defaulted_project)
      tag = project.programmings.create({programming_language_id: language.id})
      Programming.all.length.should == 1
      project.destroy
      Programming.all.length.should == 0
    end
    
    it "should delete the network records if the project that owns them is destroyed" do
      social_media = FactoryGirl.create(:social_medium, service: "facebook")
      project = FactoryGirl.create(:defaulted_project)
      network = FactoryGirl.create(:defaulted_network, social_media_id: social_media.id, networkable_type: "Project", networkable_id: project.id)
      Network.all.length.should == 1
      project.destroy
      Network.all.length.should == 0
    end
    
  end
end
