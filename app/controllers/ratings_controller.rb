class RatingsController < ApplicationController

  def create
    rating = Rating.create!(ratings_params)
    redirect_to user_path(session[:user_id])
  end


  private
    def ratings_params
      params.require(:rating).permit(
        :rating_user_id,
        :rated_user_id,
        :for_type,
        :delivery_id,
        :score
      )
    end
end
