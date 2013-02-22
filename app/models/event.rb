class Event < ActiveRecord::Base
  
  belongs_to :country
  belongs_to :state
  
  has_many :attendees, dependent: :destroy
  has_many :users, through: :attendees
  has_many :networks, as: :networkable, dependent: :destroy
  has_many :programming_languages, through: :programmings, source: :programmable, source_type: "Event"
  has_many :programmings, as: :programmable, dependent: :destroy
  has_many :event_dates, dependent: :destroy
  
  scope :include_networks, includes(:networks)
  scope :include_programmings, includes(:programmings)
  scope :approved_events, where(approved_event: true)
  scope :includes_users, includes(:users)
  scope :include_attendees_creator, includes(:attendees).where(attendees:{attendee_type: "creator"})
  scope :include_date, includes(:event_dates)
  scope :upcoming_events, where(["event_dates.date_of_event >= ?", Time.now.to_date])
  
  attr_accessible :title, :details, :address_1, :address_2, :city_province, :state_id, :country_id, :zip_code, :online_event, :event_date, :programming_language_ids
  attr_accessible :networks_attributes
  attr_accessible :programmings_attributes
  attr_accessible :event_dates_attributes
  attr_accessor :programming_language_ids
  
  accepts_nested_attributes_for :networks, reject_if: lambda{ |a| a[:account_url].blank? }, allow_destroy: true
  accepts_nested_attributes_for :programmings, allow_destroy: true
  accepts_nested_attributes_for :programming_languages
  accepts_nested_attributes_for :event_dates
  
  validates :title, :address_1, :city_province, :state_id, :country_id, :zip_code, presence: true
  
  after_save :save_programming_languages
  
  # returns query to controller based on the id of the programming language tag associated with the event. 
  # This will only return events approved by the admin.
  def self.upcoming_event_query(language_tag_id)
    if language_tag_id.present?
      Event.approved_events.joins(:programmings).where(programmings: {programming_language_id: language_tag_id})
    else
      Event.approved_events.include_date.upcoming_events.include_programmings
    end
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