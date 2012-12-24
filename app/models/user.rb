class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me, :first_name, :last_name, :nickname, :primary_role, :church, :bio, :city_province, :state_id, :country_id, :please_update
  # attr_accessible :title, :body
  validates_uniqueness_of :nickname, allow_nil: true, allow_blank: true
end
