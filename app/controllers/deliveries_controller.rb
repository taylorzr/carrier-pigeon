class DeliveriesController < ApplicationController
  def index
    if session[:user_id]
      @deliveries = Delivery.where('departure_date > ?', Date.today).where(sender_id: nil)
    else
      redirect_to login_url
    end
  end

  def new
    if session[:user_id]
      @delivery = Delivery.new
    else
      redirect_to login_url
    end
  end

  def show
    @delivery = Delivery.find(params[:id])
    @current_user = User.find(session[:user_id])
  end

  def create
    @delivery = Delivery.new(delivery_params)
    if @delivery.save
      redirect_to delivery_path(@delivery.id)
    else
      render 'new'
    end
  end

  def edit
    @delivery = Delivery.find(params[:id])
    @recipients = User.find(session[:user_id]).recipients

  end

  def update
    @delivery = Delivery.find(params[:id]).update(delivery_params)
    redirect_to delivery_path
  end

  private

  def delivery_params
    params.require(:delivery).permit(
      :carrier_id,
      :sender_id,
      :recipient_id,
      :package_size,
      :from_city,
      :to_city,
      :price,
      :departure_date,
      :arrival_date
    )
  end
end
