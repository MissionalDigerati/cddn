class Event < ActiveRecord::Base
  has_many :attendees
  has_many :users, through: :attendees
  has_many :networks, as: :networkable
  scope :include_networks, includes(:networks)
  
  attr_accessible :title, :details, :address_1, :address_2, :city_province, :state_id, :country_id, :zip_code, :online_event, :event_date
  attr_accessible :networks_attributes
  accepts_nested_attributes_for :networks, reject_if: lambda{ |a| a[:account_url].blank? }, allow_destroy: true
  
  validates :title, :address_1, :city_province, :state_id, :country_id, :zip_code, :event_date, presence: true
  
  def self.event_create_by(event)
    user = User.joins(:attendees).where(attendees: {event_id: event.id, attendee_type: 'creator'}).first
    user.nickname.present? ? user.nickname : user.email
  end
  
end
