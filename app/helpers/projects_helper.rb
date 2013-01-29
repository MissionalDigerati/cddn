module ProjectsHelper
  
  def project_creator_link(project)
    creator = project.memberships.find_by_role('creator').user
    name = creator.nickname.present? ? creator.nickname : creator.email
    link_to name, user_path(creator)
  end
  
end
