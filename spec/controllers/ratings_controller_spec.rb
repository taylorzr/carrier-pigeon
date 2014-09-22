require 'rails_helper'

describe RatingsController do
  describe 'POST #create' do
    before (:each) { session[:user_id] = 1 }
    it 'should create a new rating' do
      expect{
        post :create, rating: {
          rating_user_id: 1,
          rated_user_id: 2,
          for_type: "carrier",
          delivery_id: 1,
          score: 5
        }
      }.to change{Ratings.all.count}
    end

    it 'should redirect to the user profile page' do
      post :create, rating: {
        rating_user_id: 1,
        rated_user_id: 2,
        for_type: "carrier",
        delivery_id: 1,
        score: 5
      }
      expect(response).to redirect_to(user_path(1))
    end
  end

end
