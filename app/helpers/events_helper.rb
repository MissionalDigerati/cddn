module EventsHelper
  
  def attend_event_button(user_id, event)
    unless event.event_dates.first.date_of_event < Time.now.to_date
      if event.attendees.where(user_id: user_id, event_id: event.id, attendee_type: 'attendee').present?
        link_to 'Un-attend Event', attend_event_event_path(event), method: :put, class: "btn btn-mini"
      elsif event.attendees.where(user_id: user_id, event_id: event.id, attendee_type: 'creator').present?
        ''
      else
        link_to 'Attend Event', attend_event_event_path(event), method: :put, class: "btn btn-mini"
      end
    end
  end
  
  def view_event(event)
    link_to "View Event", event_path(event), class: "btn btn-mini btn-info" if event.approved_event == true
  end
  
end
