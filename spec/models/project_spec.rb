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
  
  describe "methods" do
    
    it "should return a regular search if no params are provided" do
      user = FactoryGirl.create(:defaulted_user)
      project = FactoryGirl.create(:defaulted_project)
      membership = FactoryGirl.create(:membership, user_id: user.id, project_id: project.id, role: "creator", status: "progress")
      search = Project.project_index_search(nil)
      search.length.should == 1
      search.include?(project).should == true
    end
    
    it "should search projects by programming language tag if and id is supplied to it" do
      #created two projects, one with a tag, one witout, created corresponding user, memberships, lanuage and tag
      language = FactoryGirl.create(:defaulted_programming_language)
      user = FactoryGirl.create(:defaulted_user)
      project_without_tag = FactoryGirl.create(:defaulted_project, name: "project without tag")
      membership = FactoryGirl.create(:membership, user_id: user.id, project_id: project_without_tag.id, role: "creator", status: "progress")
      project_with_tag = FactoryGirl.create(:defaulted_project, name: "project with tag")
      membership_2 = FactoryGirl.create(:membership, user_id: user.id, project_id: project_with_tag.id, role: "creator", status: "progress")
      tag = project_with_tag.programmings.create({programming_language_id: language.id})
      
      search = Project.project_index_search(1)
      search.length.should == 1
      search.include?(project_with_tag).should == true
      search.include?(project_without_tag).should == false
    end
    
  end
  
end
