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
  scope :joins_programmings, joins(:programmings)
  
  attr_accessible :name, :description, :license, :organization, :accepts_requests, :programming_language_ids
  attr_accessible :networks_attributes
  attr_accessor :programming_language_ids
  accepts_nested_attributes_for :networks, reject_if: lambda{ |a| a[:account_url].blank? }, allow_destroy: true
  
  
  validates :name, :description, :license, :organization, presence: true
  after_save :save_programming_languages
  
  
  def self.project_index_search(language_tag_id, accepting_requests)
    if language_tag_id.present? && accepting_requests.present?
      open_projects_with_tag(language_tag_id, accepting_requests)
    elsif language_tag_id.present?
      programming_language_search(language_tag_id)
    elsif accepting_requests.present?
      only_open_projects
    else
      regular_project_search
    end
  end
  
  def self.open_projects_with_tag(language_tag_id, accepting_requests)
    Project.open_projects.joins_programmings.where(programmings: {programming_language_id: language_tag_id})
  end
  
  #the regular project search index all projects, open or not, as long as they are approved, including their creator.
  def self.regular_project_search
    Project.approved_projects.include_creator
  end
  
  def self.programming_language_search(language_tag_id)
    Project.approved_projects.include_creator.joins_programmings.where(programmings: {programming_language_id: language_tag_id})
  end
  
  def self.only_open_projects
    Project.approved_projects.open_projects.include_creator
  end
  
  private
    def save_programming_languages
    self.programmings.destroy_all
    return if self.programming_language_ids.blank?
    self.programming_language_ids.each do |lang|
        self.programmings.create({programming_language_id: lang}) unless lang.blank?
      end
    end
end
