module ProjectsHelper
  
  def project_creator_link(project)
    creator = project.memberships.find_by_role('creator').user
    name = creator.nickname.present? ? creator.nickname : creator.email
    link_to name, user_path(creator)
  end
  
  def join_project_request_button(project, user)
    if project.memberships.where(user_id: user.id, role: "creator").present?
      ""
    elsif project.memberships.where(user_id: user.id).present? 
      link_to "Leave Project", leave_project_path(project), method: :delete, confirm: "Are you sure you want to leave the project's team?"
    elsif project.memberships.where(user_id: user.id).present? == false && project.accepts_requests == true
      link_to "Request to Join Project", join_project_path(project), method: :post
    else
      ""
    end
  end
  
end
