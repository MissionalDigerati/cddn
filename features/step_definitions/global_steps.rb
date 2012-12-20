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