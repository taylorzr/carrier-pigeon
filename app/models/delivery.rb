class Delivery < ActiveRecord::Base
  belongs_to :carrier, class_name: "User"
  belongs_to :sender, class_name: "User"
  belongs_to :recipient

  def self.available_pigeons
    self.where(sender_id: nil).where(recipient_id: nil).where("departure_date > ?", Date.today)
  end
end
