# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :programming_language do
  end
  factory :defaulted_programming_language, :parent => :programming_language do
    language "Ruby"
  end
end
