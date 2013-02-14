# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :user do
  end
  factory :defaulted_user, :parent => :user do
    email "fakeuser@test.com"
    password "testing"
    event_approved true
    project_approved true
    last_sign_in_at Time.now
    state_id 5
    country_id 226
  end
end