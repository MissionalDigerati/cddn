Given /^I am a user "(.*?)", that is a member of the project "(.*?)", and I am logged in$/ do |email_prefix, project|
  password = 'secretpassword1000'
  user = FactoryGirl.create(:defaulted_user, email: email_prefix + "@cddn.com", password: password, event_approved: false, first_name: email_prefix, nickname: email_prefix)
  project = Project.find_by_name(project)
  membership = FactoryGirl.create(:membership, user_id: user.id, project_id: project.id, status: "approved", role: "member")
  
  visit '/users/sign_in'
  fill_in "Email", with: email_prefix + "@cddn.com"
  fill_in "Password", with: password
  click_button "Sign in"
end