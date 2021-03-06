module ProjectsHelper
  
  def project_creator_link(project)
    creator = project.memberships.find_by_role('creator').user
    name = creator.nickname.present? ? creator.nickname : creator.email
    link_to name.capitalize, user_path(creator)
  end
  
  def join_project_request_button(project, user=nil)
    if user.present? && project.memberships.where(user_id: user.id, role: "creator").present?
      link_to "Manage Project", edit_project_path(project), class: "btn"
    elsif user.present? && project.memberships.where(user_id: user.id).present? 
      link_to "Leave Project", leave_project_path(project), method: :delete, class: "btn", confirm: "Are you sure you want to leave the project's team?"
    elsif user.present? && project.memberships.where(user_id: user.id).present? == false && project.accepts_requests == true
      link_to "Request to Join Project", join_project_path(project), method: :post, class: "btn"
    elsif project.accepts_requests === false
      link_to "Not currently accepting requests", "#", class: "btn"
    else
      link_to "Request to Join Project", join_project_path(project), method: :post, class: "btn"
    end
  end

  def organization_name(name)
    name.present? ? name.capitalize : "N/A"
  end
  
end
