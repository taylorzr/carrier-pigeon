require 'rails_helper'

describe UsersController do
  describe 'signup page' do
    before { get :new }

    it 'renders signup form' do
      expect(response.status).to eq 200
      expect(response).to render_template(:new)
    end

    it 'redirects user to profile page' do
      post :create, user: {name: "Clayton", username: "Tester", email: "me@example", password: "password", city: "Chicago"}
      expect(response.status).to eq 302
      expect(response).to redirect_to(user_path(assigns(:user)))
    end
  end
end
