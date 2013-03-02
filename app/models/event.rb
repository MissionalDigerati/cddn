class Event < ActiveRecord::Base
  acts_as_gmappable
  
  belongs_to :country
  belongs_to :state
  
  has_many :attendees, dependent: :destroy
  has_many :users, through: :attendees
  has_many :networks, as: :networkable, dependent: :destroy
  has_many :programming_languages, through: :programmings
  has_many :programmings, as: :programmable, dependent: :destroy
  has_many :event_dates, dependent: :destroy
  
  scope :include_networks, includes(:networks)
  scope :include_programmings, includes(:programmings)
  scope :approved_events, where(approved_event: true)
  scope :includes_users, includes(:users)
  scope :include_attendees_creator, includes(:attendees).where(attendees:{attendee_type: "creator"})
  scope :include_date, includes(:event_dates)
  scope :joins_attendees, joins(:attendees)
  scope :upcoming_events, where(["event_dates.date_of_event >= ?", Time.now.to_date])
  scope :past_events, where(["event_dates.date_of_event <= ?", Time.now.to_date])
  scope :order_by_date, order("event_dates.date_of_event asc")
  
  attr_accessible :title, :details, :address_1, :address_2, :city_province, :state_id, :country_id, :zip_code, :online_event, :event_date, :lang_tokens, :longitude, :latitude
  attr_accessible :networks_attributes
  attr_accessible :programmings_attributes
  attr_accessible :event_dates_attributes
  attr_accessor :lang_tokens
  
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
      Event.approved_events.include_date.upcoming_events.joins(:programmings).where(programmings: {programming_language_id: language_tag_id}).order_by_date
    else
      Event.approved_events.include_date.upcoming_events.include_programmings.order_by_date
    end
  end
  
  def self.past_event_query(language_tag_id)
    if language_tag_id.present?
      Event.approved_events.include_date.past_events.joins(:programmings).where(programmings: {programming_language_id: language_tag_id}).order_by_date
    else
      Event.approved_events.include_date.past_events.include_programmings.order_by_date
    end
  end
  
  def gmaps4rails_address
  #describe how to retrieve the address from your model, if you use directly a db column, you can dry your code, see wiki
    "#{self.address_1} #{self.address_2}, #{self.city_province}, #{State.find(self.state_id).state_short} #{Country.find(self.country_id).printable_name}" 
  end
  
  def gmaps4rails_infowindow
    extra = self.address_2.present? ? "#{self.address_2} <br>" : nil
    "<p>#{self.address_1}<br/> #{extra} #{self.city_province}<br/> #{State.find(self.state_id).state_short}<br/> #{Country.find(self.country_id).printable_name}</p>" 
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