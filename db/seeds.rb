# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

require 'faker'

User.create!(name: "Clayton", username: "Tester", email: "me@example", password: "password", city: "Chicacgo")

20.times do
  User.create!(name: Faker::Name.name, email: Faker::Internet.email, username: Faker::Internet.user_name, password: "password", city: Faker::Address.city)
end

1.upto(20) do |i|
  Recipient.create!(user_id: i, name: Faker::Name.name, email: Faker::Internet.email)
end

10.times do
  sender_id = (11..20).to_a.sample
  time = Time.now
  Delivery.create!(carrier_id: (1..10).to_a.sample, sender_id: sender_id, recipient_id: User.find(sender_id).recipients.first, from_city: Faker::Address.city, to_city: Faker::Address.city, price: 20, departure_date: time, arrival_date: (time+(60*60*24)))
end
