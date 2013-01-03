class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :omniauthable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me, :first_name, :last_name, :nickname, :primary_role, :church, :bio, :city_province, :state_id, :country_id, :please_update
  # attr_accessible :title, :body
  validates_uniqueness_of :nickname, allow_nil: true, allow_blank: true
  
  def self.from_twitter(auth)
    where(auth.slice(:provider, :uid)).first_or_create do |user|
      user.provider = auth.provider
      user.uid = auth.uid
      user.nickname = auth.info.nickname
      user.email = auth.uid + "twitter@noemailprovided.com"
    end
  end
  
  def self.from_github(auth)
    where(auth.slice(:provider, :uid)).first_or_create do |user|
      user.provider = auth.provider
      user.uid = auth.uid
      user.nickname = auth.info.nickname
      user.email = auth.info.email
    end
  end
  
  def self.from_facebook(auth)
    where(auth.slice(:provider, :uid)).first_or_create do |user|
      user.provider = auth.provider
      user.uid = auth.uid
      user.nickname = auth.info.name
      user.email = auth.info.email
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
