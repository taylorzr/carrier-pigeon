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
    redirect_to user_path(@user.id)
  end

  private

  def recipient_params
      params.require(:recipient).permit(:user_id, :name, :email)
  end
end
