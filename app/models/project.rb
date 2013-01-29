class Project < ActiveRecord::Base
  attr_accessible :name, :description, :license, :organization, :accepts_requests
  has_many :users, through: :memberships
  has_many :memberships, dependent: :destroy
  
  validates :name, :description, :license, :organization, presence: true
  
end
