class SocialMedia < ActiveRecord::Base
  # attr_accessible :title, :body
  has_many :networks
end
