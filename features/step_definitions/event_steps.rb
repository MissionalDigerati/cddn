Then /^I should be on the new event page$/ do
  page.current_path.should == new_event_path
end

When /^I try to access the new event page$/ do
  visit new_event_path
end

Given /^I have an event "(.*?)"$/ do |event_name|
  user = FactoryGirl.create(:defaulted_user)
  event = FactoryGirl.create(:defaulted_event, title: event_name)
  attendee = FactoryGirl.create(:defaulted_attendee, user_id: user.id, event_id: event.id, attendee_type: 'creator')
end

Then /^I should be on the events index page$/ do
  page.current_path.should == events_path
end

When /^I visit the events index page$/ do
  visit events_path
end

When /^I am on the new event page$/ do
  visit new_event_path
end

When /^I visit the my events page for "(.*?)"$/ do |email_prefix|
  user = User.find_by_email(email_prefix + "@example.com")
  visit my_events_event_path(user)
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

When /^I try to access the my events page for "(.*?)"$/ do |email_prefix|
  user = User.find_by_email(email_prefix + "@cddn.com")
  visit my_events_event_path(user)
end

When /^I try to access the edit event page for "(.*?)"$/ do |event_title|
  event = Event.find_by_title(event_title)
  visit edit_event_path(event)
end

When /^I try to view the show page for the "(.*?)" event$/ do |event_title|
  event = Event.find_by_title(event_title)
  visit event_path(event)
end

Then /^I should be on the show page for the "(.*?)" event$/ do |event_title|
  event = Event.find_by_title(event_title)
  page.current_path.should == event_path(event)
end

Given /^I am a user "(.*?)", and I have an event "(.*?)", and I have a ruby language tag, and I am logged in$/ do |email_prefix, event|
  password = 'secretpassword1000'
  user = FactoryGirl.create(:defaulted_user, email: email_prefix + "@cddn.com", password: password)
  event = FactoryGirl.create(:defaulted_event, title: event)
  attendee = FactoryGirl.create(:defaulted_attendee, user_id: user.id, event_id: event.id, attendee_type: "creator")
  language = ProgrammingLanguage.first
  event.programmings.create(programming_language_id:language.id)
  
  visit '/users/sign_in'
  fill_in "Email", with: email_prefix + "@cddn.com"
  fill_in "Password", with: password
  click_button "Sign in"
end

Given /^I am a user "(.*?)", and I have an event "(.*?)", and I have a smalltalk tag, and I am not logged in$/ do |email_prefix, event|
  password = 'secretpassword1000'
  user = FactoryGirl.create(:defaulted_user, email: email_prefix + "@cddn.com", password: password)
  event = FactoryGirl.create(:defaulted_event, title: event)
  attendee = FactoryGirl.create(:defaulted_attendee, user_id: user.id, event_id: event.id, attendee_type: "creator")
  language = ProgrammingLanguage.last
  event.programmings.create(programming_language_id:language.id)
end

