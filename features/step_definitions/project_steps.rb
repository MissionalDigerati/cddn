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
  user = FactoryGirl.create(:defaulted_user, email: email_prefix + "@cddn.com", password: password)
  project = FactoryGirl.create(:defaulted_project, name: project)
  membership = FactoryGirl.create(:membership, user_id: user.id, project_id: project.id, role: "creator", status: "progress")
  
  visit '/users/sign_in'
  fill_in "Email", with: email_prefix + "@cddn.com"
  fill_in "Password", with: password
  click_button "Sign in"
end

Given /^I am a user "(.*?)" and I have a project "(.*?)", and I am not logged in$/ do |email_prefix, project|
  password = 'secretpassword1000'
  user = FactoryGirl.create(:defaulted_user, email: email_prefix + "@cddn.com", password: password)
  project = FactoryGirl.create(:defaulted_project, name: project)
  membership = FactoryGirl.create(:membership, user_id: user.id, project_id: project.id, role: "creator", status: "progress")
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
