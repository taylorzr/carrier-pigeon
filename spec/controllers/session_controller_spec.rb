require 'rails_helper'

describe SessionsController do
  context '#new' do
    it 'should render a login page if no user is logged in' do
      get :new
      expect(response).to render_template(:new)
    end

    it 'should redirect to the users profile if already logged in' do
      session[:user_id] = 42
      get :new
      expect(response).to redirect_to(user_path(42))
    end
  end

  context '#create' do
    before (:each) { User.create!(email: "taylorzr@gmail.com", username: "taylorzr", password: "pass")}

    it 'should redirect to the login form with invalid username' do
      post :create, username: "taco", password: "bad"
      expect(response).to redirect_to(login_path)
    end

    it 'should redirect to the login form with invalid password' do
      post :create, username: "taylorzr", password: "bad"
      expect(response).to redirect_to(login_path)
    end

    it 'should redirect to the users profile with valid input' do
      post :create, username: "taylorzr", password: "pass"
      expect(response).to redirect_to(user_path(1))
    end

    it 'should place a user_id in the session with valid input' do
      post :create, username: "taylorzr", password: "pass"
      expect(session[:user_id]).not_to be_nil
    end
  end

  context '#destroy' do
    it 'should redirect to the root' do
      post :destroy
      expect(response).to redirect_to(root_path)
    end

    it 'should clear user_id from the session' do
      session[:user_id] = 42
      post :destroy
      expect(session[:user_id]).to be_nil
    end
  end
end