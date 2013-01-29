# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :project do
  end
  factory :defaulted_project, parent: :project do
    name "project123"
    description "project description"
    license "license"
    organization "organization"
    accepts_requests false
  end
end
