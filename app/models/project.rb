class Project < ActiveRecord::Base
  attr_accessible :name, :description, :license, :organization, :accepts_requests
  has_many :users, through: :memberships
  has_many :memberships, dependent: :destroy
  scope :include_creator, includes(:memberships).where(memberships:{role: 'creator'})
  scope :include_memberships, includes(:memberships)
  
  validates :name, :description, :license, :organization, presence: true
  
end
