class Membership < ActiveRecord::Base
  # attr_accessible :title, :body
  belongs_to :user
  belongs_to :project
  
  validates :user_id, :project_id, :role, presence: true
end
