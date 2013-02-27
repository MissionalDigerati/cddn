When /^I fill in tag label with "(.*?)" and click enter$/ do |tag|
  fill_in "user_lang_tokens", with: tag
  find_field('token-input-list-facebook').native.send_key(:enter)
end