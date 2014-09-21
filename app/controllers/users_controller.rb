class UsersController < ApplicationController

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)

    if @user.save
      session[:user_id] = @user.id
      redirect_back_or user_path(session[:user_id])
    else
      redirect_to new_user_path
    end
  end

  def show
    @user = User.find(params[:id])
    @rating = Rating.new
  end

  private

    def user_params
        params.require(:user).permit(:name, :username, :email, :password, :city)
    end

    def redirect_back_or(default)
      redirect_to(default || session[:return_to])
      session.delete(:return_to)
    end

end
