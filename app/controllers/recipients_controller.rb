class RecipientsController < ApplicationController
  respond_to :html, :js

  def index
  end

  def new
    user = User.find(session[:user_id])
    @recipient = user.recipients.new

    if request.xhr?
      render :partial => "new", locals: { recipient: @recipient }
    end
  end

  def create
    @user = User.find(session[:user_id])
    @recipient = Recipient.create(recipient_params)
    if request.xhr?
      return 200
    else
      redirect_back_or user_path(@user.id)
    end
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
