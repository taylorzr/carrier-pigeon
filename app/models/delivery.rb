class Delivery < ActiveRecord::Base
  belongs_to :carrier, class_name: "User"
  belongs_to :sender, class_name: "User"
  belongs_to :recipient
end
