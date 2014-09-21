class WelcomeController < ApplicationController
  def index
    @deliveries = Delivery.available_pigeons
  end
end
