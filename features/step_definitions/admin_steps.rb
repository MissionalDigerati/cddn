Given /^I have an admin account "(.*?)"$/ do |email_prefix|
  FactoryGirl.create(:defaulted_admin, email: email_prefix + "@cddn.com", password: "secret1")
end

When /^I visit the admin login page$/ do
  visit new_admin_session_path
end

Given /^I have an admin account "(.*?)" and I am logged in$/ do |email_prefix|
  password = 'secretpassword1000'
  FactoryGirl.create(:defaulted_admin, email: email_prefix + "@cddn.com", password: password)

  visit '/admins/sign_in'
  fill_in "Email", with: email_prefix + "@cddn.com"
  fill_in "Password", with: password
  click_button "Sign in"
end