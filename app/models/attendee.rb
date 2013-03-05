class Attendee < ActiveRecord::Base
  belongs_to :user
  belongs_to :event
  attr_accessible :user_id, :event_id, :attendee_type
  scope :include_event, includes(:event)
  validates :user_id, :event_id, :attendee_type, presence: true
  
  # for the create action, if the save is successful this method is called where it sets the foreign keys for the attendee tables and creates the record bridiging the two tables together. 
  def self.attendee_creation(user_id, event, role)
    attendee = event.attendees.new
    attendee.user_id = user_id
    attendee.attendee_type = role
    attendee.save
  end
  
end
