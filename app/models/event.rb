class Event < ActiveRecord::Base
  has_many :attendees
  has_many :users, through: :attendees
  has_many :networks, as: :networkable
  
  attr_accessible :title, :details, :address_1, :address_2, :city_province, :state_id, :country_id, :zip_code, :online_event, :event_date

  validates :title, :address_1, :city_province, :state_id, :country_id, :zip_code, :event_date, presence: true
  
  def self.event_create_by(event)
    user = User.joins(:attendees).where(attendees: {event_id: event.id, attendee_type: 'creator'}).first
    user.nickname.present? ? user.nickname : user.email
  end
  
end
