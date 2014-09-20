require 'rails_helper'
require 'spec_helper'

describe DeliveriesController do

  before(:each) do
    user = User.create!(name: "Zach", email: "taylorzr@gmail.com", password: "password")
    Delivery.create!(carrier: user, from_city: "Here" ,to_city: "There", departure_date: "2014-12-12")
    Delivery.create!(carrier: user, from_city: "Aqui" ,to_city: "Alla")

  end

  describe '#index' do
    it 'must redirect unlogged users to login page' do
      get :index
      expect(response).to redirect_to(login_url)
    end

    it 'must not redirect logged users to login page' do
      session[:user_id] = 1
      get :index
      expect(response.status).to eq 200
    end

    it 'has a variable that contains multiple objects' do
      session[:user_id] = 1
      get :index
      expect(assigns(:carrier_deliveries).length).to be(1)
    end

  end

  describe '#new' do
  end

  describe '#create' do
  end
end