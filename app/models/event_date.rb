class EventDate < ActiveRecord::Base
  belongs_to :event
  attr_accessible :event_id, :date_of_event, :time_of_event
  validates :event_id, :date_of_event, :time_of_event, presence: true
end
