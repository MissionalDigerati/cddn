module ApplicationHelper
  
  def logged_in_as(user)
    if user.nickname.present? && user.provider.present?
      user.nickname + " from " + user.provider
    else
      user.email
    end
  end
  
  def attendee_creator_name(event)
    creator = event.attendees.find_by_attendee_type("creator").user
    if creator.nickname.present?
      creator.nickname
    elsif creator.first_name.present?
      creator.first_name
    else
      creator.email
    end
  end
  
  def yes_or_no(arg)
    arg == true ? "Yes" : "No"
  end
  
end
