Then /^I should be on the user sign up page$/ do
  page.current_path.should == new_user_registration_path
end

Then /^I should be on the user sign in page$/ do
  page.current_path.should == new_user_session_path
end

Then /^I visit the user dash board for "(.*?)"$/ do |username|
  user = User.where(first_name: username).first
  visit users_dashboard_path(user)
end

When /^I visit the brag page for "(.*?)"$/ do |username|
  user = User.where(first_name: username).first
  visit user_path(user)
end

Then /^I should still be on the user dash board for "(.*?)"$/ do |username|
  user = User.where(first_name: username).first
  page.current_path.should == users_dashboard_path(user)
end

Then /^I should be on the dashboard for "(.*?)"$/ do |username|
  user = User.where(first_name: username).first
  page.current_path.should == users_dashboard_path(user)
end

When /^I access the "(.*?)" edit page$/ do |username|
  user = User.where(first_name: username).first
  visit edit_user_path(user)
end

Then /^I should be redirected to the dashboard for "(.*?)"$/ do |user_email|
  user = User.where(email: user_email).first
  page.current_path.should == users_dashboard_path(user)
end

Given /^I am a user "(.*?)" and I am have a ruby language tag and I am logged in$/ do |email_prefix|
  password = 'secretpassword1000'
  user = FactoryGirl.create(:defaulted_user, email: email_prefix + "@cddn.com", password: password, event_approved: false, first_name: email_prefix)
  language = ProgrammingLanguage.first
  user.programmings.create(programming_language_id:language.id)
  
  visit '/users/sign_in'
  fill_in "Email", with: email_prefix + "@cddn.com"
  fill_in "Password", with: password
  click_button "Sign in"
end

Given /^I am a user "(.*?)" and I am logged in and I have a language tag ruby$/ do |email_prefix|
  password = 'secretpassword1000'
  user = FactoryGirl.create(:defaulted_user, email: email_prefix + "@cddn.com", password: password, event_approved: false, first_name: email_prefix)
  language = ProgrammingLanguage.first
  user.programmings.create(programming_language_id:language.id)
  visit '/users/sign_in'
  fill_in "Email", with: email_prefix + "@cddn.com"
  fill_in "Password", with: password
  click_button "Sign in"
end