class Project < ActiveRecord::Base

  belongs_to :license
  
  has_many :users, through: :memberships
  has_many :memberships, dependent: :destroy
  has_many :networks, as: :networkable, dependent: :destroy
  has_many :programming_languages, through: :programmings
  has_many :programmings, as: :programmable, dependent: :destroy
  
  scope :include_creator, includes(:memberships).where(memberships:{role: 'creator'})
  scope :include_memberships, includes(:memberships)
  scope :include_networks, includes(:networks)
  scope :approved_projects, where(approved_project: true)
  scope :include_programmings, includes(:programmings)
  scope :open_projects, where(accepts_requests: true)
  scope :joins_programmings, joins(:programmings)
  
  attr_accessible :name, :description, :license_id, :organization, :accepts_requests, :lang_tokens, :license_name
  attr_accessible :networks_attributes
  attr_accessor :lang_tokens
  accepts_nested_attributes_for :networks, reject_if: lambda{ |a| a[:account_url].blank? }, allow_destroy: true
  
  validates :name, :description, :license_id, presence: true

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
    self.open_projects.joins_programmings.where(programmings: {programming_language_id: language_tag_id})
  end
  
  #the regular project search index all projects, open or not, as long as they are approved, including their creator.
  def self.regular_project_search
    self.approved_projects.include_creator
  end
  
  def self.programming_language_search(language_tag_id)
    self.approved_projects.include_creator.joins_programmings.where(programmings: {programming_language_id: language_tag_id})
  end
  
  def self.only_open_projects
    self.approved_projects.open_projects.include_creator
  end

  def license_name
    license.try(:license_title)
  end

  def license_name=(title)
    self.license = License.find_by_license_title(title) if title.present?
  end
  
  private
  
    def save_programming_languages
      self.programmings.destroy_all
      return if self.lang_tokens.blank?
      lang_tokens.split(",").each do |lang|
        self.programmings.create({programming_language_id: lang}) unless lang.blank?
      end
    end
end
