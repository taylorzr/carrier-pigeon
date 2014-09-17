class DeliveriesController < ApplicationController
  def index
    @deliveries = Delivery.where(sender_id: nil)
  end

  def new
    @delivery = Delivery.new
  end

  def create
    @delivery = Delivery.new(delivery_params)
    if @delivery.save
      redirect_to delivery_path
    else
      render 'new'
    end
  end

  private

  def delivery_params
    params.require(:delivery).permit(
      :package_size,
      :from_city,
      :to_city,
      :price,
      :departure_date,
      :arrival_date
    )
  end
end
