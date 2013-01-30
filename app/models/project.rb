class Project < ActiveRecord::Base
  has_many :users, through: :memberships
  has_many :memberships, dependent: :destroy
  has_many :networks, as: :networkable, dependent: :destroy
  scope :include_creator, includes(:memberships).where(memberships:{role: 'creator'})
  scope :include_memberships, includes(:memberships)
  scope :include_networks, includes(:networks)
  
  attr_accessible :name, :description, :license, :organization, :accepts_requests
  attr_accessible :networks_attributes
  accepts_nested_attributes_for :networks, reject_if: lambda{ |a| a[:account_url].blank? }, allow_destroy: true
  
  
  validates :name, :description, :license, :organization, presence: true
  
end
