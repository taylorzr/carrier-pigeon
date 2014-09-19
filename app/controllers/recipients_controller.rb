class RecipientsController < ApplicationController

  def index
  end

  def new
    user = User.find(session[:user_id])
    @recipient = user.recipients.new
    # @user.recipients << @recipient
  end
end
