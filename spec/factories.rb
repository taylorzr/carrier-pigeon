FactoryGirl.define do
  factory :user do
    name "John"
    username  "Doe"
    password "password"
  end
end

FactoryGirl.define do
  factory :delivery do
    carrier_id 1
    sender_id  2
    recipient_id 1
    package_size "Large"
    from_city "Chicago"
    to_city "Austin"
    departure_date Date.today
    arrival_date Date.tomorrow
  end
end
