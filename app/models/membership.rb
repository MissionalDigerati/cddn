class Membership < ActiveRecord::Base
  attr_accessible :user_id, :project_id, :role, :status
  belongs_to :user
  belongs_to :project
  validates :user_id, :project_id, :role, presence: true
  
  def self.membership_creation(user_id, project, role, status)
    project.memberships.create({user_id: user_id, role: role, status: status})
  end
  
  def self.join_project_request(project, user)
    if project.memberships.find_by_role("creator").user_id == user.id
      return
    else
      project.memberships.create({user_id: user.id, project_id: project.id, status: "pending", role: "member"})
    end
  end
  
end
