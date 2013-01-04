# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :admin do
  end
  factory :defaulted_admin, :parent => :admin do
    email "admin@cddntest.com"
    password "testing123"
  end
end
