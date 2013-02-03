class Project < ActiveRecord::Base
  has_many :users, through: :memberships
  has_many :memberships, dependent: :destroy
  has_many :networks, as: :networkable, dependent: :destroy
  has_many :programming_languages, through: :programmings, source: :programmable, source_type: "Project"
  has_many :programmings, as: :programmable, dependent: :destroy
  scope :include_creator, includes(:memberships).where(memberships:{role: 'creator'})
  scope :include_memberships, includes(:memberships)
  scope :include_networks, includes(:networks)
  scope :approved_projects, where(approved_project: true)
  scope :include_programmings, includes(:programmings)
  scope :open_projects, where(accepts_requests: true)
  
  attr_accessible :name, :description, :license, :organization, :accepts_requests, :programming_language_ids
  attr_accessible :networks_attributes
  attr_accessor :programming_language_ids
  accepts_nested_attributes_for :networks, reject_if: lambda{ |a| a[:account_url].blank? }, allow_destroy: true
  
  
  validates :name, :description, :license, :organization, presence: true
  after_save :save_programming_languages
  
  
  private
    def save_programming_languages
    self.programmings.destroy_all
    return if self.programming_language_ids.blank?
    self.programming_language_ids.each do |lang|
        self.programmings.create({programming_language_id: lang}) unless lang.blank?
      end
    end
end
