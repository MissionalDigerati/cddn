# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :social_medium, :class => 'SocialMedia' do
  end
  factory :defaulted_social_media, :parent => :social_medium do
    service "Facebook"
  end
end
