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

Then /^I should see "([^"]*)" in the "([^"]*)" input$/ do |content, labeltext|
    find_field("#{labeltext}").value.should == content
end

Then /^I should not see "(.*?)" in the "(.*?)" input$/ do |content, labeltext|
  find_field("#{labeltext}").value.should_not == content
end

Given /^I am a user "(.*?)", and I have an event "(.*?)", and I am not logged in, and I am not approved for event creation$/ do |email_prefix, event|
  password = 'secretpassword1000'
  user = FactoryGirl.create(:defaulted_user, email: email_prefix + "@cddn.com", password: password, event_approved: false, first_name: email_prefix)
  event = FactoryGirl.create(:defaulted_event, title: event, approved_event: false)
  attendee = FactoryGirl.create(:defaulted_attendee, user_id: user.id, event_id: event.id, attendee_type: "creator")
end

When /^I visit the users events index page$/ do
  visit events_path
end

Then /^I check the "(.*?)" checkbox$/ do |checkbox|
  check(checkbox)
end