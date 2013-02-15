# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :event_date do
  end
  factory :defaulted_event_date, :parent => :event_date do
    date_of_event Time.now.to_date
    time_of_event Time.now
  end
end
