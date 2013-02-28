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
  
  describe "aftersave" do
    it "should create the correct programming language tags when the lang_token passes the ids for the corresponding languages" do
      language = FactoryGirl.create(:defaulted_programming_language, language: "Ruby")
      project = FactoryGirl.build(:defaulted_project, lang_tokens: "1")
      project.save
      project.programmings.length.should == 1
      project.programmings.first.programmable_id.should == project.id
      project.programmings.first.programmable_type.should == "Project"
      project.programmings.first.programming_language_id.should == language.id
    end
    
    it "should not create a programmings record for the event if no programming language ids are passed" do
      project = FactoryGirl.build(:defaulted_project, lang_tokens: nil)
      project.save
      project.programmings.length.should == 0
    end
  end
  
  
  describe "methods" do
    
    it "should return a regular search if no params are provided including both open and closed projects returning projects with tags as well." do
      language = FactoryGirl.create(:defaulted_programming_language)
      user = FactoryGirl.create(:defaulted_user)
      project = FactoryGirl.create(:defaulted_project)
      project_not_open = FactoryGirl.create(:defaulted_project, accepts_requests: false)
      project_with_tag = FactoryGirl.create(:defaulted_project)
      membership = FactoryGirl.create(:membership, user_id: user.id, project_id: project.id, role: "creator", status: "progress")
      membership_not_open = FactoryGirl.create(:membership, user_id: user.id, project_id: project_not_open.id, role: "creator", status: "progress")
      membership_with_tag = FactoryGirl.create(:membership, user_id: user.id, project_id: project_with_tag.id, role: "creator", status: "progress")
      tag = project_with_tag.programmings.create({programming_language_id: language.id})
      
      search = Project.project_index_search(nil, nil)
      search.length.should == 3
    end
    
    it "should search for projects with the searched tag, that are both open and closed for requests." do
      #four projects are created, 3 with tags, some approved some not approved, however one is filteed out because it does not have a programming language tag
      language = FactoryGirl.create(:defaulted_programming_language)
      user = FactoryGirl.create(:defaulted_user)
      project = FactoryGirl.create(:defaulted_project)
      project_not_open = FactoryGirl.create(:defaulted_project, accepts_requests: false)
      project_with_tag = FactoryGirl.create(:defaulted_project)
      project_without_tag = FactoryGirl.create(:defaulted_project, accepts_requests: true)
      membership = FactoryGirl.create(:membership, user_id: user.id, project_id: project.id, role: "creator", status: "progress")
      membership_not_open = FactoryGirl.create(:membership, user_id: user.id, project_id: project_not_open.id, role: "creator", status: "progress")
      membership_with_tag = FactoryGirl.create(:membership, user_id: user.id, project_id: project_with_tag.id, role: "creator", status: "progress")
      membership_without_tag = FactoryGirl.create(:membership, user_id: user.id, project_id: project_without_tag.id, role: "creator", status: "progress")
      project_with_tag.programmings.create({programming_language_id: language.id})
      project.programmings.create({programming_language_id: language.id})
      project_not_open.programmings.create({programming_language_id: language.id})
      
      search = Project.project_index_search(1, nil)
      search.length.should == 3
      search.include?(project_without_tag).should == false
    end
    
    it "should filter projects based on if they are accepting requests or not" do  
      # two projects are created, one that is accepting requests and one that is not. 
      user = FactoryGirl.create(:defaulted_user)
      project_not_open = FactoryGirl.create(:defaulted_project, accepts_requests: false)
      project_open = FactoryGirl.create(:defaulted_project, accepts_requests: true)
      membership_not_open = FactoryGirl.create(:membership, user_id: user.id, project_id: project_not_open.id, role: "creator", status: "progress")
      membership_open = FactoryGirl.create(:membership, user_id: user.id, project_id: project_open.id, role: "creator", status: "progress")
      
      search = Project.project_index_search(nil, 1)
      search.length.should == 1
      search.include?(project_open).should == true
      search.include?(project_not_open).should == false
    end
    
    it "should filter projects by programming language tag as well as if they are open or not" do
      #4 projects are created, 1 unapproved without tag, 1 unapproved with tag, 1 approved without tag, and only 1 approved with tag, thus the search will only return 1
      language = FactoryGirl.create(:defaulted_programming_language)
      user = FactoryGirl.create(:defaulted_user)
      project_without_tag_accepting = FactoryGirl.create(:defaulted_project)
      project_without_tag_not_accepting = FactoryGirl.create(:defaulted_project, accepts_requests: false)
      project_with_tag_not_accepting = FactoryGirl.create(:defaulted_project, accepts_requests: false)
      project_with_tag_accepting = FactoryGirl.create(:defaulted_project)
      FactoryGirl.create(:membership, user_id: user.id, project_id: project_without_tag_accepting.id, role: "creator", status: "progress")
      FactoryGirl.create(:membership, user_id: user.id, project_id: project_without_tag_not_accepting.id, role: "creator", status: "progress")
      FactoryGirl.create(:membership, user_id: user.id, project_id: project_with_tag_not_accepting.id, role: "creator", status: "progress")
      FactoryGirl.create(:membership, user_id: user.id, project_id: project_with_tag_accepting.id, role: "creator", status: "progress")
      project_with_tag_not_accepting.programmings.create({programming_language_id: language.id})
      project_with_tag_accepting.programmings.create({programming_language_id: language.id})
      
      search = Project.project_index_search(1, 1)
      search.length.should == 1
      search.include?(project_with_tag_accepting).should == true
    end
    
  end
  
end
