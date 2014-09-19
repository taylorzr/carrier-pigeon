class User < ActiveRecord::Base
  has_many :carried_deliveries, class_name: "Delivery", foreign_key: "carrier_id"
  has_many :sent_deliveries, class_name: "Delivery", foreign_key: "sender_id"
  has_many :recipients
  has_many :ratings

  validates :email, uniqueness: :true, presence: :true

  has_secure_password

  def carrier_rating
    assesments = Rating.where(rated_user: self.id).where(for_type: "carrier")

    average = "Unrated"


    if assesments.length > 0
      assesment_values = assesments.map{|entry| entry.rating}

      average = (assesment_values.inject{ |sum, el| sum + el }.to_f / assesment_values.size).round(2)
    end

    return average

  end

  def sender_rating
    assesments = Rating.where(rated_user: self.id).where(for_type: "sender")
    average = "Unrated"

    puts "#{assesments} sup"

    if assesments.length > 0
      assesment_values = assesments.map{|entry| entry.rating}

      average = (assesment_values.inject{ |sum, el| sum + el }.to_f / assesment_values.size).round(2)
    end
    return average
  end
end
