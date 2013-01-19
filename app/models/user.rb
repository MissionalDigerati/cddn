class User < ActiveRecord::Base
  scope :approved, where(event_approved: true)
  scope :event_unapproved, where(event_approved: false)
  scope :attendee_event_creator, joins(:attendees).where(attendees:{attendee_type: 'creator'})
  scope :include_events, includes(:events)
  has_many :attendees
  has_many :events, through: :attendees
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :omniauthable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me, :first_name, :last_name, :nickname, :primary_role, :church, :bio, :city_province, :state_id, :country_id, :please_update
  # attr_accessible :title, :body
  validates_uniqueness_of :nickname, allow_nil: true, allow_blank: true
  
  
  #if the provider is facebook then it sets the user's nickname to the facebook name (which is the users first and last name)
  #if no email is provided then one is generated for the sake of requiring one on the cddn appliation
  def self.omniauth_all(auth)
    where(auth.slice(:provider, :uid)).first_or_create do |user|
      user.provider = auth.provider
      user.uid = auth.uid
      auth.provider == "facebook" ? user.nickname = auth.info.name : user.nickname = auth.info.nickname
      auth.info.email.present? ? user.email = auth.info.email : user.email = auth.uid + "@noemailprovided.com"
      user.first_name = auth.info.first_name
      user.last_name = auth.info.last_name
    end
  end
  
  #a session prefisex with devise. will be automaticall taken care of devise, there is no need to remove it. (according to railscasts)
  #This methon is not called, rather it is a hook, incase the hash containing the user auth data is somehow faulty (does not pass validations)
  #the user will be bounced to a page where they can update that information according to the error message. 
  def self.new_with_session(params, session)
    if session["devise.user_attributes"]
      new(session["devise.user_attributes"], without_protection: true) do |user|
        user.attributes = params
        user.valid?
      end
    else
      super
    end
  end
  
  def password_required?
    super && provider.blank?
  end
  
  def update_with_password(params, *options)
    if encrypted_password.blank?
      update_attributes(params, *options)
    else
      super
    end
  end
  
end
