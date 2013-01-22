# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :network do
  end
  factory :defaulted_network, :parent => :network do
    account_name "Sammy Simmons"
    account_url "http://www.facebook.com/"
  end
end
