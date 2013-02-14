# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :country do
  end
  factory :defaulted_country, :parent => :country do
    iso "US" 
    name "UNITED STATES"
    printable_name "United States"
    iso3 "USA"
    numcode 840
  end
end
