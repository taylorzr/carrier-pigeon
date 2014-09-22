require 'rails_helper'

describe 'Delivery' do
  before(:each) do
    @user1 = User.create(name: "Clayton", username: "Tester", email: "me@example", password_digest: "password", city: "Chicago")
    @user2 = User.create(name: "Mrs. Adolfo Fadel", username: "rosalee_renner", email: "jaron.mohr@blicklakin.info", password_digest: "password", city: "East Kaden")
    @delivery = Delivery.create(
      carrier_id: 1, 
      sender_id: 2, 
      recipient_id: 1, 
      package_size: "Large", 
      from_city: "Chicago", 
      to_city: "Austin", 
      price: 20, 
      departure_date: Date.today, 
      arrival_date: Date.tomorrow
    )
    @recipient = Recipient.create(user_id: 2, name: "Theo", email: "test")
  end

  it "should show that the carrier is 'Clayton'" do
    expect(@delivery.carrier.name).to eq('Clayton')
  end

  it "should show that the sender is 'Mrs. Adolfo Fadel'" do
    expect(@delivery.sender.name).to eq('Mrs. Adolfo Fadel')
  end

  it "should show that the recipient is 'Theo'" do
    expect(@delivery.recipient.name).to eq('Theo')
  end

  it "should have a package size of large" do
    expect(@delivery.package_size).to eq("Large")
  end

  it "should have a from_city of Chicago" do
    expect(@delivery.from_city).to eq("Chicago")
  end

  it "should have a to_city of Austin" do
    expect(@delivery.to_city).to eq("Austin")
  end

  it "should have a price of 20" do
    expect(@delivery.price).to eq(20)
  end

  it "should have a departure date of today" do
    expect(@delivery.departure_date).to eq(Date.today)
  end

  it "should have a arrival date tomorrow" do
    expect(@delivery.arrival_date).to eq(Date.tomorrow)
  end

  describe '#rate_sender?' do
    it 'should return false if the sender has not been rated' do
      expect(@delivery.rate_sender?).to be_truthy
    end

    it 'should return true if the sender has been rated' do
      sender = @delivery.sender
      Rating.create!(rated_user: sender, for_type: "sender", delivery: @delivery)
      expect(@delivery.rate_sender?).to be_falsey
    end
  end

  describe '#rate_carrier?' do
    it 'should return false if the sender has not been rated' do
      expect(@delivery.rate_sender?).to be_truthy
    end

    it 'should return true if the sender has been rated' do
      carrier = @delivery.carrier
      Rating.create!(rated_user: carrier, for_type: "carrier", delivery: @delivery)
      expect(@delivery.rate_carrier?).to be_falsey
    end
  end

  describe '::available_pigeons' do 
    before (:each) do
      @delivery = Delivery.create!(
        carrier_id: 1, 
        from_city: "Chicago", 
        to_city: "Austin", 
        price: 20, 
        departure_date: Date.tomorrow, 
        arrival_date: Date.tomorrow
      )
    end

    it 'should return a list of deliveries without senders' do
      expect(Delivery.available_pigeons.count).to eq(1)
    end

    it 'should return an empty list if there are no deliveries without senders' do
      @delivery.update!(sender_id: 1, recipient_id: 1)
      expect(Delivery.available_pigeons.count).to eq(0)
    end
  end
end
