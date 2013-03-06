# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :event do
  end
  factory :defaulted_event, :parent => :event do
    title "event title"
    details "Lorem ipsum dolor sit amet, consectetur adipisicing elit"
    address_1 "123 fake street"
    city_province "San Jose"
    state_id 5
    country_id 226
    zip_code "21345"
    online_event false
    approved_event true
    event_time "value"
    event_date "value"
  end
end
