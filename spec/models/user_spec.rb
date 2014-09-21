require 'rails_helper'

describe 'User' do
  before(:each) do
    @user1 = User.create(name: "Clayton", username: "Tester", email: "me@example", password_digest: "password", city: "Chicago")
    @user2 = User.create(name: "Mrs. Adolfo Fadel", username: "rosalee_renner", email: "jaron.mohr@blicklakin.info", password_digest: "password", city: "East Kaden")
    @delivery = Delivery.create(carrier_id: 1, sender_id: 2, recipient_id: 1, package_size: "Large", from_city: "Chicago", to_city: "Austin", price: 20, departure_date: Date.today, arrival_date: Date.tomorrow)
    @recipient = Recipient.create(user_id: 2, name: "Theo", email: "test")
    @rating = Rating.create(for_type: "carrier", rating_user_id: 2, rated_user_id: 1, delivery_id: 1, score: 5)

  end

  it 'assigns carried delivery' do
    expect(@user1.carried_deliveries.size).to eq(1)
    expect(@user1.sent_deliveries.size).to eq(0)
  end

  it 'assigns sent delivery' do
    expect(@user2.carried_deliveries.size).to eq(0)
    expect(@user2.sent_deliveries.size).to eq(1)
  end

  it 'shows the correct number of deliveries' do
    expect(@user2.sent_deliveries.size).to eq(1)
  end

  it 'shows the correct number of recipients' do
    expect(@user2.recipients.size).to eq(1)
  end

  it 'should assign rating to carrier' do
    expect(@user1.ratings.size).to eq(1)
  end

  it 'should display the correct rating score' do
    expect(@user1.ratings.first.score).to eq(5)
  end

  context '#requested_sends' do
    before(:each) do
      @requested_sends_delivery = Delivery.create!(sender_id: 2, recipient_id: 1, package_size: "Large", from_city: "Chicago", to_city: "Austin", price: 20, departure_date: Date.tomorrow, arrival_date: Date.tomorrow)
    end
    it 'should return 1 requested deliveries' do
      expect(@user2.requested_sends.size).to eq(1)
    end
  end

  context '#pending_sends' do
    before(:each) do
      @pending_sends_delivery = Delivery.create!(carrier_id: 1, sender_id: 2, recipient_id: 1, package_size: "Large", from_city: "Chicago", to_city: "Austin", price: 20, departure_date: Date.tomorrow, arrival_date: Date.tomorrow)

    end
    it 'should return 1 pending delivery' do
      expect(@user2.pending_sends.size).to eq(1)
    end
  end

  context '#completed_sends' do
    before(:each) do
      @completed_sends_delivery = Delivery.create!(carrier_id: 1, sender_id: 2, recipient_id: 1, package_size: "Large", from_city: "Chicago", to_city: "Austin", price: 20, departure_date: Date.yesterday, arrival_date: Date.tomorrow)

    end
    it 'should return 1 completed delivery' do
      expect(@user2.completed_sends.size).to eq(1)
    end
  end

  context '#incomplete_sends' do
    before(:each) do
      @incomplete_sends_delivery = Delivery.create!(carrier_id: nil, sender_id: 2, recipient_id: 1, package_size: "Large", from_city: "Chicago", to_city: "Austin", price: 20, departure_date: Date.yesterday, arrival_date: Date.tomorrow)

    end
    it 'should return 1 incomplete delivery' do
      expect(@user2.incomplete_sends.size).to eq(1)
    end
  end

  context '#requested_carries' do
    before(:each) do
      @requested_carries_delivery = Delivery.create!(carrier_id: 1, sender_id: nil, recipient_id: nil, package_size: "Large", from_city: "Chicago", to_city: "Austin", price: 20, departure_date: Date.tomorrow, arrival_date: Date.tomorrow)

    end
    it 'should return 1 incomplete delivery' do
      expect(@user1.requested_carries.size).to eq(1)
    end
  end

  context '#pending_carries' do
    before(:each) do
      @pending_carries_delivery = Delivery.create!(carrier_id: 1, sender_id: 2, recipient_id: 1, package_size: "Large", from_city: "Chicago", to_city: "Austin", price: 20, departure_date: Date.tomorrow, arrival_date: Date.tomorrow)

    end
    it 'should return 1 incomplete delivery' do
      expect(@user1.pending_carries.size).to eq(1)
    end
  end

  context '#completed_carries' do
    before(:each) do
      @completed_carries_delivery = Delivery.create!(carrier_id: 1, sender_id: 2, recipient_id: 1, package_size: "Large", from_city: "Chicago", to_city: "Austin", price: 20, departure_date: Date.yesterday, arrival_date: Date.yesterday)

    end
    it 'should return 1 complete delivery' do
      expect(@user1.completed_carries.size).to eq(1)
    end
  end

  context '#incomplete_carries' do
    before(:each) do
      @incomplete_carries_delivery = Delivery.create!(carrier_id: 1, sender_id: nil, recipient_id: nil, package_size: "Large", from_city: "Chicago", to_city: "Austin", price: 20, departure_date: Date.yesterday, arrival_date: Date.yesterday)

    end
    it 'should return 1 incomplete delivery' do
      expect(@user1.incomplete_carries.size).to eq(1)
    end
  end

end
