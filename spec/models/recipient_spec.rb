require 'rails_helper'

describe 'Recipient' do
  let (:user) { User.create(name: "Clayton", username: "Tester", email: "me@example", password_digest: "password", city: "Chicago") }
  let (:recipient) { Recipient.create(user: user, name: "Theo", email: "test") }

  it "should belong to user" do
    expect(recipient).to belong_to(:user)
  end

  it "should belong to a 'Mrs. Adolfo Fadel'" do
    expect(recipient.user.name).to eq("Clayton")
  end

  it "should have a name of 'Theo'" do
    expect(recipient.name).to eq("Theo")
  end

  it "should have a email of 'test'" do
    expect(recipient.email).to eq("test")
  end
end
