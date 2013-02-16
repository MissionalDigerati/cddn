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
  
  def display_programming_tags(programmings_ids)
    langs_to_display = []
    ProgrammingLanguage.all.each do |lang|
      if programmings_ids.include?(lang.id)
        langs_to_display << lang.language
      end
    end
    langs_to_display
  end
  
  def check_lang(lang_array, lang_id)
    lang_array.include?(lang_id)
  end
  
  def programming_select
    ProgrammingLanguage.all.collect {|p| [ p.language, p.id ] }
  end
  
  def link_to_users_profile(user)
    name = user.nickname.present? ? user.nickname : user.email
    link_to name.capitalize, user_path(user)
  end
  
  def network_service(network)
    "#{network.social_media.service}: "
  end
  
  def networking_link(network)
    link_to "#{network.account_name}", network.account_url
  end
  
  def state_drop_down
    State.all.collect {|s| [s.state_long, s.id]}
  end
  
  def country_drop_down
    Country.all.collect {|c| [c.printable_name, c.id]}
  end
  
  def display_state_name(state_id)
    state_id.present? ? State.find(state_id).state_long : ""
  end
  
  def display_country_name(country_id)
    country_id.present? ? Country.find(country_id).printable_name : ""
  end
  
  def date_format(event_date)
    event_date.date_of_event.strftime('%m/%d/%Y') if event_date.present?
  end
end