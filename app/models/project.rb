class Project < ActiveRecord::Base
  # attr_accessible :title, :body
  has_many :users, through: :memberships
  has_many :memberships, dependent: :destroy
  
  validates :name, :description, :license, :organization, presence: true
end
