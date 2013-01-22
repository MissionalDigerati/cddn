Given /^I am a user "(.*?)" and I have a network "(.*?)" I am logged in$/ do |username, network_name|
  password = 'secretpassword1000'
  user = FactoryGirl.create(:defaulted_user, first_name: username, email: username + "@example.com", password: password, bio: "bio")
  social_media = FactoryGirl.create(:defaulted_social_media, service: network_name)
  FactoryGirl.create(:defaulted_network, social_media_id: social_media.id, networkable_id: user.id, networkable_type: "User", account_name: network_name, account_url: "http://www." + network_name + ".com")

  visit '/users/sign_in'
  fill_in "user_email", :with=> username + "@example.com"
  fill_in "user_password", :with=>password
  click_button "Sign in"
end

When /^I select "(.*?)" from "(.*?)"$/ do |value, select_box|
  select(value, :from => select_box)
end
