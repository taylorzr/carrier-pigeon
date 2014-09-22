require 'rails_helper'

describe DeliveriesController do

  before(:each) do
    @user = User.create!(name: "Zach", email: "taylorzr@gmail.com", password: "password")
    Delivery.create!(carrier: @user, from_city: "Here" ,to_city: "There", departure_date: "2014-12-12")
    Delivery.create!(carrier: @user, from_city: "Aqui" ,to_city: "Alla")
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

  describe 'GET #new' do
    before (:each) { session[:user_id] = 42 }

    it 'should redirect unless a user is logged in' do
      session.delete(:user_id)
      get :new
      expect(response).to redirect_to login_url
    end

    it 'should provide a new delivery' do
      get :new
      expect(assigns(:delivery)).to be_a(Delivery)
    end

    it 'should provide an array of sender deliveries' do
      get :new
      expect(assigns(:sender_deliveries)).not_to be_nil
    end

    it 'should render the new view' do
      get :new
      expect(response).to render_template(:new)
    end
  end

  describe 'GET #show' do
    before (:each) do
      session[:user_id] = 1
      get :show, id: 1
    end

    it 'should provide a delivery' do
      expect(assigns(:delivery)).to be_a(Delivery)
    end

    it 'should provide the current user' do
      expect(assigns(:current_user)).to be_a(User)
    end
  end

  describe 'POST #create' do
    it 'should redirect to the new delivery' do
      post :create, delivery: { carrier_id: 1 }
      expect(response).to redirect_to delivery_path(3)
    end

    it 'should create a new delivery' do
      expect{ post :create, delivery: { carrier_id: 1 } }.to change{ Delivery.all.count }
    end
  end

  describe 'GET #edit' do
    before (:each) do
      session[:user_id] = 1
    end

    it 'should redirect to login if not authenticated' do
      session.delete(:user_id)
      get :edit, id: 1
      expect(response).to redirect_to login_url
    end

    it 'should provide a delivery' do 
      get :edit, id: 1
      expect(assigns(:delivery)).to be_a(Delivery)
    end

    it 'should provide an array of recipients' do 
      get :edit, id: 1
      expect(assigns(:recipients)).not_to be_nil
    end

    it 'should render the edit form' do
      get :edit, id: 1
      expect(response).to render_template(:edit)
    end
  end

  describe 'PUT #update' do
    it 'should redirect to the updated delivery' do
      post :update, id: 1, delivery: { carrier_id: 1 }
      expect(response).to redirect_to(delivery_path(1))
    end
  end
end