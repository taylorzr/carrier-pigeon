class RecipientsController < ApplicationController

  def index
  end

  def new
    user = User.find(session[:user_id])
    @recipient = user.recipients.new
  end

  def create
    @user = User.find(session[:user_id])
    @recipient = Recipient.create(recipient_params)
    redirect_back_or user_path(@user.id)
  end

  private

    def recipient_params
        params.require(:recipient).permit(:user_id, :name, :email)
    end

    def redirect_back_or(default)
      redirect_to(session[:return_to] || default)
      session.delete(:return_to)
    end
end
