namespace :db do
  
  desc "creates new event dates for events with re occuring dates"
  task :date_update => :environment do
    require 'ice_cube'
    
    events_for_updating = []
    @events = Event.recurring.include_date
    
    @events.each do |event|
      if event.event_dates.last.date_of_event < Time.now.to_date
        events_for_updating << event
      end
    end
    
    events_for_updating.each do |event|
      if event.recurring_schedule == "weekly"
        rule = IceCube::Rule.weekly(event.recurring_interval)
        schedule = IceCube::Schedule.new(event.event_dates.last.date_of_event)
        schedule.add_recurrence_rule(rule)
        new_date = schedule.next_occurrence.to_date.to_s
        event.event_dates.create(date_of_event: new_date, time_of_event: event.event_dates.last.time_of_event)
      elsif event.recurring_schedule == "monthly"
        rule = IceCube::Rule.monthly(event.recurring_interval)
        schedule = IceCube::Schedule.new(event.event_dates.last.date_of_event)
        schedule.add_recurrence_rule(rule)
        new_date = schedule.next_occurrence.to_date.to_s
        event.event_dates.create(date_of_event: new_date, time_of_event: event.event_dates.last.time_of_event)
      elsif event.recurring_schedule == "yearly"
        rule = IceCube::Rule.yearly(event.recurring_interval)
        schedule = IceCube::Schedule.new(event.event_dates.last.date_of_event)
        schedule.add_recurrence_rule(rule)
        new_date = schedule.next_occurrence.to_date.to_s
        event.event_dates.create(date_of_event: new_date, time_of_event: event.event_dates.last.time_of_event)
      end
    end
    
  end
  
end