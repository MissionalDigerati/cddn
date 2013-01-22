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
  
  def network_service_select
    SocialMedia.all.collect {|p| [ p.service, p.id ] }
  end
  
  
  def link_to_add_fields(name, f, association)
    new_object = f.object.send(association).klass.new
    id = new_object.object_id
    fields = f.fields_for(association, new_object, child_index: id ) do |builder|
      render( association.to_s.singularize + "_fields", f: builder )
    end
    link_to(name, '#', class: "add_fields btn btn-small btn-danger", data: {id: id, fields: fields.gsub("/n", "")})
  end
  
end
