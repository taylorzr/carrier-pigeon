class RecipientsController < ApplicationController
 
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
    @recipient = @user.recipients.create!(recipient_params)

    if request.xhr?
      #render :text => 'test!'
      render :nothing => true
      # render :json => {:user_id => @user.id, :recipient_name => @recipient.name, :recipient_email => @recipient.email}
      # render :create # this happens by default
    else
      redirect_back_or user_path(@user.id)
    end
  end

  private

    def recipient_params
        params.require(:recipient).permit(:name, :email)
    end

    def redirect_back_or(default)
      redirect_to(session[:return_to] || default)
      session.delete(:return_to)
    end
end
