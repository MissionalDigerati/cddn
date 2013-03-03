Then /^I should be on the new project page$/ do
  current_path.should == new_project_path
end

Then /^I should be on the project show page for "(.*?)"$/ do |title|
  project = Project.find_by_name(title)
  current_path.should == project_path(project)
end

When /^I try to access the new project form page$/ do
  visit new_project_path
end

Given /^I am a user "(.*?)" and I have a project "(.*?)", and I am logged in$/ do |email_prefix, project|
  password = 'secretpassword1000'
  user = FactoryGirl.create(:defaulted_user, email: email_prefix + "@cddn.com", password: password, first_name: email_prefix)
  project = FactoryGirl.create(:defaulted_project, name: project)
  membership = FactoryGirl.create(:membership, user_id: user.id, project_id: project.id, role: "creator", status: "progress", creator_id: user.id)
  
  visit '/users/sign_in'
  fill_in "Email", with: email_prefix + "@cddn.com"
  fill_in "Password", with: password
  click_button "Sign in"
end

Given /^I am a user not approved for project creation "(.*?)" and I am logged in$/ do |email_prefix|
  password = 'secretpassword1000'
  user = FactoryGirl.create(:defaulted_user, email: email_prefix + "@cddn.com", password: password, first_name: email_prefix, project_approved: false)
  
  visit '/users/sign_in'
  fill_in "Email", with: email_prefix + "@cddn.com"
  fill_in "Password", with: password
  click_button "Sign in"
end

Given /^I am a user "(.*?)" and I have a project "(.*?)", and I am not logged in$/ do |email_prefix, project|
  password = 'secretpassword1000'
  user = FactoryGirl.create(:defaulted_user, email: email_prefix + "@cddn.com", password: password)
  project = FactoryGirl.create(:defaulted_project, name: project)
  membership = FactoryGirl.create(:membership, user_id: user.id, project_id: project.id, role: "creator", status: "active", creator_id: user.id)
end

Given /^I am a user "(.*?)" and I have a project "(.*?)", that is not accepting requests, and I am not logged in$/ do |email_prefix, project|
  password = 'secretpassword1000'
  user = FactoryGirl.create(:defaulted_user, email: email_prefix + "@cddn.com", password: password)
  project = FactoryGirl.create(:defaulted_project, name: project, accepts_requests: false)
  membership = FactoryGirl.create(:membership, user_id: user.id, project_id: project.id, role: "creator", status: "progress", creator_id: user.id)
end

When /^I try to access the edit project page for "(.*?)"$/ do |title|
  project = Project.find_by_name(title)
  visit edit_project_path(project)
end

When /^I visit the projects index$/ do
  visit projects_path
end

Given /^I am on the new project page$/ do
  visit new_project_path
end

Given /^I am a user "(.*?)" and I have a project "(.*?)", and I am not approved for project creation$/ do |email_prefix, project|
  password = 'secretpassword1000'
  user = FactoryGirl.create(:defaulted_user, email: email_prefix + "@cddn.com", password: password, project_approved: false)
  project = FactoryGirl.create(:defaulted_project, name: project, approved_project: false)
  membership = FactoryGirl.create(:membership, user_id: user.id, project_id: project.id, role: "creator", status: "progress", creator_id: user.id)
  
  visit '/users/sign_in'
  fill_in "Email", with: email_prefix + "@cddn.com"
  fill_in "Password", with: password
  click_button "Sign in"
end

Then /^I should be on the user dashboard for "(.*?)"$/ do |first_name|
  user = User.where(first_name: first_name).first
  page.current_path.should == users_dashboard_path(user)
end

Given /^I am a user "(.*?)" and I have a project "(.*?)", that has a language tag, and I am not logged in$/ do |email_prefix, project|
  password = 'secretpassword1000'
  user = FactoryGirl.create(:defaulted_user, email: email_prefix + "@cddn.com", password: password)
  project = FactoryGirl.create(:defaulted_project, name: project, accepts_requests: true)
  membership = FactoryGirl.create(:membership, user_id: user.id, project_id: project.id, role: "creator", status: "progress", creator_id: user.id)
  language = ProgrammingLanguage.first
  project.programmings.create(programming_language_id:language.id)
end

Given /^I am a user "(.*?)" and I have a project "(.*?)", that has a language tag, that is not accepting requests, and I am not logged in$/ do |email_prefix, project|
  password = 'secretpassword1000'
  user = FactoryGirl.create(:defaulted_user, email: email_prefix + "@cddn.com", password: password)
  project = FactoryGirl.create(:defaulted_project, name: project, accepts_requests: false)
  membership = FactoryGirl.create(:membership, user_id: user.id, project_id: project.id, role: "creator", status: "progress", creator_id: user.id)
  language = ProgrammingLanguage.first
  project.programmings.create(programming_language_id:language.id)
end

Given /^I am a user "(.*?)" and I have a project "(.*?)", that is not approved for project creation, and I am not logged in$/ do |email_prefix, project|
  password = 'secretpassword1000'
  user = FactoryGirl.create(:defaulted_user, email: email_prefix + "@cddn.com", password: password, project_approved: false)
  project = FactoryGirl.create(:defaulted_project, name: project, approved_project: false)
  membership = FactoryGirl.create(:membership, user_id: user.id, project_id: project.id, role: "creator", status: "progress", creator_id: user.id)
end

Given /^"(.*?)" is a "(.*?)" member of the "(.*?)"$/ do |user_name, status, project_name|
  creator = User.first
  project = Project.find_by_name(project_name)
  user = User.find_by_email(user_name + "@cddn.com")
  membership = FactoryGirl.create(:membership, user_id: user.id, project_id: project.id, role: "member", status: "approved", creator_id: creator.id)
end

Then /^I should be on the my project page for "(.*?)"$/ do |user_name|
  user = User.find_by_email(user_name + '@cddn.com')
  page.current_path.should == my_projects_user_path(user)
end

When /^I try to access the my project page for "(.*?)"$/ do |user_name|
  user = User.find_by_email(user_name + '@cddn.com')
  visit my_projects_user_path(user)
end


