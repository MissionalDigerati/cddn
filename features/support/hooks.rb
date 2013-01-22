Before do
  # SocialMedia.create(service: "Facebook")
  #  SocialMedia.create(service: "GitHub")
  #  SocialMedia.create(service: "Twitter")
  FactoryGirl.create(:defaulted_social_media)
  FactoryGirl.create(:defaulted_social_media, service: "GitHub")
  FactoryGirl.create(:defaulted_social_media, service: "Twitter")
end