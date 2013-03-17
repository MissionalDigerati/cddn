class Membership < ActiveRecord::Base
  
  belongs_to :user
  belongs_to :project

  attr_accessible :user_id, :project_id, :role, :status, :creator_id
  
  validates :user_id, :project_id, :role, :status, :creator_id, presence: true
  
  def self.membership_creation(user_id, project)
    project.memberships.create({creator_id: user_id, user_id: user_id, role: "creator", status: 'active'})
  end
  
  def self.join_project_request(project, user)
    creator = project.memberships.find_by_role("creator")
    if creator.creator_id == user.id || project.memberships.where(user_id: user.id).present?
      return
    else
      project.memberships.create({user_id: user.id, project_id: project.id, status: "pending", role: "member", creator_id: creator.creator_id})
    end
  end
  
  def self.leave_project(project, user)
    membership = Membership.where(project_id: project.id, user_id: user.id, role: "member").first
    membership.delete if membership.present?
  end
  
  def self.membership_approve_deny(membership, updated_value)
    membership.status = updated_value
    membership.save
  end
  
end
