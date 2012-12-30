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
