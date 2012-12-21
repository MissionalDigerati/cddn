Given /^I am on the home page$/ do
  visit root_path
end

When /^I click the "(.*?)" link$/ do |link|
  click_on link
end

When /^I fill in "(.*?)" with "(.*?)"$/ do |form_name, form_content|
  fill_in form_name, with: form_content
end

When /^I click the "(.*?)" button$/ do |button|
  click_on button
end

Then /^I should be on the home page$/ do
  page.current_path.should == root_path
end

Then /^I should see "(.*?)"$/ do |text|
  page.should have_content text
end

Given /^I have a user "(.*?)"$/ do |username|
  FactoryGirl.create(:defaulted_user, first_name: username, email: username + "@example.com", password: "testing123", nickname: username + " nickname")
end

Given /^I am a user "(.*?)" and I am logged in$/ do |username|
  password = 'secretpassword1000'
  FactoryGirl.create(:defaulted_user, first_name: username, email: username + "@example.com", password: password, bio: "bio")

  visit '/users/sign_in'
  fill_in "user_email", :with=> username + "@example.com"
  fill_in "user_password", :with=>password
  click_button "Sign in"
end


Then /^I should not see "(.*?)"$/ do |text|
  page.should_not have_content text
end