Then /^I should be on the new event page$/ do
  page.current_path.should == new_event_path
end

When /^I try to access the new event page$/ do
  visit new_event_path
end

Given /^I have an event "(.*?)"$/ do |event_name|
  FactoryGirl.create(:defaulted_event, title: event_name)
end

Then /^I should be on the events index page$/ do
  page.current_path.should == events_path
end

When /^I visit the events index page$/ do
  visit events_path
end

Given /^I am a user "(.*?)", and I have an event "(.*?)", and I am logged in$/ do |email_prefix, event|
  password = 'secretpassword1000'
  user = FactoryGirl.create(:defaulted_user, email: email_prefix + "@cddn.com", password: password)
  event = FactoryGirl.create(:defaulted_event, title: event)
  attendee = FactoryGirl.create(:defaulted_attendee, user_id: user.id, event_id: event.id, attendee_type: "creator")
  
  visit '/users/sign_in'
  fill_in "Email", with: email_prefix + "@cddn.com"
  fill_in "Password", with: password
  click_button "Sign in"
end

Given /^I am a user "(.*?)", and I have an event "(.*?)", and I am not logged in$/ do |email_prefix, event|
  password = 'secretpassword1000'
  user = FactoryGirl.create(:defaulted_user, email: email_prefix + "@cddn.com", password: password)
  event = FactoryGirl.create(:defaulted_event, title: event)
  attendee = FactoryGirl.create(:defaulted_attendee, user_id: user.id, event_id: event.id, attendee_type: "creator")
end