class Attendee < ActiveRecord::Base
  belongs_to :user
  belongs_to :event
  # attr_accessible :title, :body
  
  # def self.create_record(user, event)
  #   attendee = user.event.attrndees.new
  #   attendee.attendee_type = "creator"
  #   attendee.save
  # end
  
end
