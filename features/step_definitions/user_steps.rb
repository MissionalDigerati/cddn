Then /^I should be on the user sign up page$/ do
  page.current_path.should == new_user_registration_path
end

Then /^I should be on the user sign in page$/ do
  page.current_path.should == new_user_session_path
end