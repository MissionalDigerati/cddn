# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :attendee do
  end
  factory :defaulted_attendee, :parent => :attendee do
  end
end
