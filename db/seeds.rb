require 'faker'

User.create!(name: "Clayton", username: "Tester", email: "me@example", password: "password", city: "Chicago")

20.times do
  User.create!(name: Faker::Name.name, email: Faker::Internet.email, username: Faker::Internet.user_name, password: "password", city: Faker::Address.city)
end

1.upto(21) do |i|
  5.times { Recipient.create!(user_id: i, name: Faker::Name.name, email: Faker::Internet.email) }
end

#past deliveries with carrier_id and sender_id
30.times do
  carrier_id = (1..10).to_a.sample
  sender_id = (11..21).to_a.sample
  package_size = ["Small", "Medium", "Large"].sample
  time = Date.today - 7
  Delivery.create!(carrier_id: carrier_id, sender_id: sender_id, recipient_id: User.find(sender_id).recipients.first, from_city: Faker::Address.city, to_city: Faker::Address.city, price: 20, package_size: package_size, departure_date: time, arrival_date: (time + 1))
end

#future delivery with carrier_id and sender_id
30.times do
  carrier_id = (1..10).to_a.sample
  sender_id = (11..21).to_a.sample
  package_size = ["Small", "Medium", "Large"].sample
  time = Date.today + 7
  Delivery.create!(carrier_id: carrier_id, sender_id: sender_id, recipient_id: User.find(sender_id).recipients.first, from_city: Faker::Address.city, to_city: Faker::Address.city, price: 20, package_size: package_size, departure_date: time, arrival_date: (time + 1))
end

#future delivery without sender_id
30.times do
  carrier_id = (1..10).to_a.sample
  time = Date.today + 7
  package_size = ["Small", "Medium", "Large"].sample
  Delivery.create!(carrier_id: carrier_id, from_city: Faker::Address.city, to_city: Faker::Address.city, price: 20, package_size: package_size, departure_date: time, arrival_date: (time + 1))
end

#future delivery without carrier_id
30.times do
  sender_id = (1..10).to_a.sample
  price = (10..100).to_a.sample
  package_size = ["Small", "Medium", "Large"].sample
  time = Date.today + 7
  Delivery.create!(sender_id: sender_id, from_city: Faker::Address.city, to_city: Faker::Address.city, price: 20, package_size: package_size )
end
