# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :state do
  end
  factory :defaulted_state, :parent => :state do
    id 5
    state_long "California"
    state_short "CA"
  end
end
