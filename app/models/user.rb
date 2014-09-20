class User < ActiveRecord::Base
  has_many :carried_deliveries, class_name: "Delivery", foreign_key: "carrier_id"
  has_many :sent_deliveries, class_name: "Delivery", foreign_key: "sender_id"
  has_many :recipients
  has_many :ratings, foreign_key: "rated_user_id"

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

  def requested_sends

    self.sent_deliveries.where('departure_date > ?', Date.today).where(carrier_id: nil)
    #no carrier_id, date is in future
  end

  def pending_sends
     self.sent_deliveries.where('departure_date > ?', Date.today).where(carrier_id: nil)

    #yes carrier_id, date is in future
  end

  def completed_sends
    #yes carrier_id, date is in future
  end

  def incomplete_sends
    #no carrier_id, yes recipient_id, date is in past
  end

  def requested_carries
    #no sender_id, no recipient_id, date is in future
  end

  def pending_carries
    #yes sender_id, yes recipient_id, date is in future
  end

  def completed_carries
    #yes sender_id, yes recipient_id, date is in past
  end

  def incomplete_carries
    #yes sender_id, yes recipient_id, date is in past

  end

  # def future_sent_deliveries
  #   self.sent_deliveries.where(carrier_id: nil)
  # end

  # def past_sent_deliveries
  #   self.sent_deliveries.where('departure_date < ?', Date.today).where.not(carrier_id: nil)
  # end

  # def future_carried_deliveries
  #   self.carried_deliveries.where('departure_date > ?', Date.today).where(sender_id: nil)
  # end

  # def past_carried_deliveries
  #   self.carried_deliveries.where('departure_date < ?', Date.today).where.not(sender_id: nil)
  # end

end
