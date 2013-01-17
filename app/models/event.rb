class Event < ActiveRecord::Base
  has_many :attendees
  has_many :users, through: :attendees
  
  attr_accessible :title, :details, :address_1, :address_2, :city_province, :state_id, :country_id, :zip_code, :online_event, :event_date

  validates :title, :address_1, :city_province, :state_id, :country_id, :zip_code, :event_date, presence: true
  
  def self.event_create_by(event)
    user = Attendee.where("event_id = #{event.id} AND attendee_type = 'creator'").first.user
    user.nickname.present? ? user.nickname : user.email
  end
  
  def self.events_by_approved_users(events)
    approved_events = Array.new
    events.each do |event|
      if event.attendees.find_by_attendee_type('creator').user.event_approved == true
        approved_events << event
      end
    end
    approved_events
  end
  
end
