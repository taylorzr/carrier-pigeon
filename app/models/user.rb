class User < ActiveRecord::Base
  has_many :carried_deliveries, class_name: "Delivery", foreign_key: "carrier_id"
  has_many :sent_deliveries, class_name: "Delivery", foreign_key: "sender_id"
  has_many :recipients

  has_secure_password
end
