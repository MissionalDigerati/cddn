Given /^I have an admin account "(.*?)"$/ do |email_prefix|
  FactoryGirl.create(:defaulted_admin, email: email_prefix + "@cddn.com", password: "secret1")
end

When /^I visit the admin login page$/ do
  visit new_admin_session_path
end

Given /^I have an admin account "(.*?)" and I am logged in$/ do |email_prefix|
  password = 'secretpassword1000'
  FactoryGirl.create(:defaulted_admin, email: email_prefix + "@cddn.com", password: password)

  visit '/admin/admins/sign_in'
  fill_in "Email", with: email_prefix + "@cddn.com"
  fill_in "Password", with: password
  click_button "Sign in"
end

When /^I try to access the admin user index page$/ do
  visit admin_users_path
end

Then /^I should be on the admin sign in page$/ do
  page.current_path.should == new_admin_session_path
end

When /^I click the "(.*?)" button for "(.*?)"$/ do |link, title|
  within(:xpath, "//table/tr[contains(.,'#{title}')]") do
    click_link link
  end
end

Given /^I am a user "(.*?)" and I am logged in and I have a suspended account$/ do |email_prefix|
  password = 'secretpassword1000'
  user = FactoryGirl.create(:defaulted_user, email: email_prefix + "@cddn.com", password: password, suspended: true)
  
  visit '/users/sign_in'
  fill_in "Email", with: email_prefix + "@cddn.com"
  fill_in "Password", with: password
  click_button "Sign in"
end

Given /^I have a user "(.*?)" and they are suspended$/ do |username|
    FactoryGirl.create(:defaulted_user, first_name: username, email: username + "@example.com", password: "testing123", nickname: username + " nickname", suspended: true)
end

When /^I try to access the admin event index page$/ do
  visit admin_events_path
end