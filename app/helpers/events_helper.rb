module EventsHelper
  
  def attend_event_button(event)
    if event.attendees.where(user_id: current_user.id, event_id: event.id, attendee_type: 'attendee').present?
      link_to 'Un-attend Event', attend_event_event_path(event), method: :put, class: "btn btn-mini"
    elsif event.attendees.where(user_id: current_user.id, event_id: event.id, attendee_type: 'creator').present?
      ''
    else
      link_to 'Attend Event', attend_event_event_path(event), method: :put, class: "btn btn-mini"
    end
  end
  
end
