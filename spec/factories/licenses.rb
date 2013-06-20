# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :license do
  end
  factory :defaulted_license, parent: :license do
    license_title "default license"
  end
end