class Membership < ActiveRecord::Base
  attr_accessible :user_id, :project_id, :role, :status, :team_approved
  belongs_to :user
  belongs_to :project
  validates :user_id, :project_id, :role, presence: true
  
  def self.membership_creation(user_id, project, role, status, approved)
    project.memberships.create({user_id: user_id, role: role, status: status, team_approved: approved})
  end
  
end
