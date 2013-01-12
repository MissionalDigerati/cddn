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