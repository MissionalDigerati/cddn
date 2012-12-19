# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :user do
  end
  factory :defaulted_user, :parent => :user do
    email "fakeuser@test.com"
    password "testing"
  end
end