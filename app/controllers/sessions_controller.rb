class SessionsController < ApplicationController

  def create
    @user = User.find_by(username: params[:username])

    if @user.authenticate(params[:password]) # Need to fix
      redirect_to users_path
    else
      # flash[:error] = "Wrong login info"
      redirect_to login_path
    end
  end

end
