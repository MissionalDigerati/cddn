Before do
  # SocialMedia.create(service: "Facebook")
  #  SocialMedia.create(service: "GitHub")
  #  SocialMedia.create(service: "Twitter")
  FactoryGirl.create(:defaulted_social_media)
  FactoryGirl.create(:defaulted_social_media, service: "GitHub")
  FactoryGirl.create(:defaulted_social_media, service: "Twitter")
  FactoryGirl.create(:defaulted_programming_language)
  FactoryGirl.create(:defaulted_programming_language, language: "SmallTalk")
  FactoryGirl.create(:state, id: 5, state_long: "California", state_short: "CA")
  FactoryGirl.create(:country, id: 226, iso: "US", name: "UNITED STATES", printable_name: "United States", iso3: "USA", numcode: 840)
end