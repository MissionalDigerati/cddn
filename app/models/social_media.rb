class SocialMedia < ActiveRecord::Base
  attr_accessible :id, :service
  has_many :networks
end
