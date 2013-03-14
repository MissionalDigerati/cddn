# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :project do
  end
  factory :defaulted_project, parent: :project do
    name "project123"
    description "project description"
    license_id 0
    organization "organization"
    accepts_requests true
    approved_project true
  end
end
