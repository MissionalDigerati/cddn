class Event < ActiveRecord::Base
  has_many :attendees, dependent: :destroy
  has_many :users, through: :attendees
  has_many :networks, as: :networkable, dependent: :destroy
  has_many :programming_languages, through: :programmings, source: :programmable, source_type: "Event"
  has_many :programmings, as: :programmable, dependent: :destroy
  scope :include_networks, includes(:networks)
  scope :include_programmings, includes(:programmings)
  scope :approved_events, where(approved_event: true)
  
  attr_accessible :title, :details, :address_1, :address_2, :city_province, :state_id, :country_id, :zip_code, :online_event, :event_date, :programming_language_ids
  attr_accessible :networks_attributes
  attr_accessible :programmings_attributes
  attr_accessor :programming_language_ids
  accepts_nested_attributes_for :networks, reject_if: lambda{ |a| a[:account_url].blank? }, allow_destroy: true
  accepts_nested_attributes_for :programmings, allow_destroy: true
  accepts_nested_attributes_for :programming_languages
  
  validates :title, :address_1, :city_province, :state_id, :country_id, :zip_code, :event_date, presence: true
  
  after_save :save_programming_languages
  
  def self.event_create_by(event)
    user = User.joins(:attendees).where(attendees: {event_id: event.id, attendee_type: 'creator'}).first
    user.nickname.present? ? user.nickname : user.email
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