class Delivery < ActiveRecord::Base
  belongs_to :carrier, class_name: "User"
  belongs_to :sender, class_name: "User"
  belongs_to :recipient
  has_many :ratings

  def self.available_pigeons
    self.where(sender_id: nil).where(recipient_id: nil).where("departure_date > ?", Date.today)
  end

  def rate_sender?
    self.ratings.where(for_type: "sender").size == 0 ? true : false
  end

  def rate_carrier?
    self.ratings.where(for_type: "carrier").size == 0 ? true : false
  end
end
