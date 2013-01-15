class Event < ActiveRecord::Base
  has_many :attendees
  has_many :users, through: :attendees
  
  attr_accessible :title, :details, :address_1, :address_2, :city_province, :state_id, :country_id, :zip_code, :online_event

  validates :title, :address_1, :city_province, :state_id, :country_id, :zip_code, presence: true
  
  def self.event_create_by(event)
    user = Attendee.where("event_id = #{event.id} AND attendee_type = 'creator'").first.user
    user.nickname.present? ? user.nickname : user.email
  end
  
end
