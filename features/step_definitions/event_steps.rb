Then /^I should be on the new event page$/ do
  page.current_path.should == new_event_path
end

When /^I try to access the new event page$/ do
  visit new_event_path
end

Given /^I have an event "(.*?)"$/ do |event_name|
  user = FactoryGirl.create(:defaulted_user)
  event = FactoryGirl.create(:defaulted_event, title: event_name)
  event.event_dates.create(date_of_event: Time.now, time_of_event: Time.now)
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
  visit my_events_user_path(user)
end

Given /^I am a user "(.*?)", and I have an event "(.*?)", and I am logged in$/ do |email_prefix, event|
  password = 'secretpassword1000'
  user = FactoryGirl.create(:defaulted_user, email: email_prefix + "@cddn.com", password: password)
  event = FactoryGirl.create(:defaulted_event, title: event)
  event.event_dates.create(date_of_event: Time.now, time_of_event: Time.now)
  attendee = FactoryGirl.create(:defaulted_attendee, user_id: user.id, event_id: event.id, attendee_type: "creator")
  
  visit '/users/sign_in'
  fill_in "Email", with: email_prefix + "@cddn.com"
  fill_in "Password", with: password
  click_button "Sign in"
end

Given /^I am a user "(.*?)", and I have an event "(.*?)", and I am logged in, and I am not approved for event creation$/ do |email_prefix, event|
  password = 'secretpassword1000'
  user = FactoryGirl.create(:defaulted_user, email: email_prefix + "@cddn.com", password: password, event_approved: false)
  event = FactoryGirl.create(:defaulted_event, title: event, approved_event: false)
  event.event_dates.create(date_of_event: Time.now, time_of_event: Time.now)
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
  event.event_dates.create(date_of_event: Time.now, time_of_event: Time.now)
  attendee = FactoryGirl.create(:defaulted_attendee, user_id: user.id, event_id: event.id, attendee_type: "creator")
end

When /^I try to access the my events page for "(.*?)"$/ do |email_prefix|
  user = User.find_by_email(email_prefix + "@cddn.com")
  visit my_events_user_path(user)
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
  event.event_dates.create(date_of_event: Time.now, time_of_event: Time.now)
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
  event.event_dates.create(date_of_event: Time.now, time_of_event: Time.now)
  attendee = FactoryGirl.create(:defaulted_attendee, user_id: user.id, event_id: event.id, attendee_type: "creator")
  language = ProgrammingLanguage.last
  event.programmings.create(programming_language_id:language.id)
end

Given /^I am a user "(.*?)", and I have a past event "(.*?)", and I have a ruby language tag, and I am logged in$/ do |email_prefix, event|
  password = 'secretpassword1000'
  user = FactoryGirl.create(:defaulted_user, email: email_prefix + "@cddn.com", password: password)
  event = FactoryGirl.create(:defaulted_event, title: event)
  event.event_dates.create(date_of_event: 1.week.ago.to_date, time_of_event: Time.now)
  attendee = FactoryGirl.create(:defaulted_attendee, user_id: user.id, event_id: event.id, attendee_type: "creator")
  language = ProgrammingLanguage.first
  event.programmings.create(programming_language_id:language.id)
  
  visit '/users/sign_in'
  fill_in "Email", with: email_prefix + "@cddn.com"
  fill_in "Password", with: password
  click_button "Sign in"
end

Given /^I am a user "(.*?)", and I have a past event "(.*?)", and I have a smalltalk tag, and I am not logged in$/ do |email_prefix, event|
  password = 'secretpassword1000'
  user = FactoryGirl.create(:defaulted_user, email: email_prefix + "@cddn.com", password: password)
  event = FactoryGirl.create(:defaulted_event, title: event)
  event.event_dates.create(date_of_event: 1.week.ago.to_date, time_of_event: Time.now)
  attendee = FactoryGirl.create(:defaulted_attendee, user_id: user.id, event_id: event.id, attendee_type: "creator")
  language = ProgrammingLanguage.last
  event.programmings.create(programming_language_id:language.id)
end

Given /^I am a user "(.*?)" that is not approved for event creation, and I am logged in$/ do |email_prefix|
  password = 'secretpassword1000'
  user = FactoryGirl.create(:defaulted_user, email: email_prefix + "@cddn.com", password: password, event_approved: false)
  
  visit '/users/sign_in'
  fill_in "Email", with: email_prefix + "@cddn.com"
  fill_in "Password", with: password
  click_button "Sign in"
end

Given /^I am a user "(.*?)", and I have an event "(.*?)", that is a past event, that is not logged in$/ do |email_prefix, event|
  password = 'secretpassword1000'
  user = FactoryGirl.create(:defaulted_user, email: email_prefix + "@cddn.com", password: password)
  event = FactoryGirl.create(:defaulted_event, title: event)
  event.event_dates.create(date_of_event: 1.weeks.ago, time_of_event: 1.weeks.ago)
end

When /^I access the past events page$/ do
  visit past_events_path
end

Then /^I should be on the past events page$/ do
  current_path.should == past_events_path
end

Then /^I should be on the event show page for "(.*?)"$/ do |title|
  event = Event.find_by_title(title)
  current_path.should == event_path(event)
end

Then /^I should be on the my events page for "(.*?)"$/ do |email_prefix|
  user = User.find_by_email(email_prefix + "@cddn.com")
  current_path.should == my_events_user_path(user)
end
