class EventDate < ActiveRecord::Base
  belongs_to :event
  attr_accessible :event_id, :date_of_event, :time_of_event
  validates :date_of_event, :time_of_event, presence: true
  
  def self.create_event_date(event)
    event.event_dates.create(date_of_event: event.event_date, time_of_event: event.event_time)
  end
  
  def self.update_event_date(event)
    event_date = event.event_dates.last
    event_date.update_attributes(date_of_event: event.event_date, time_of_event: event.event_time)
  end
end
