class Network < ActiveRecord::Base
  attr_accessible :social_media_id, :account_name, :account_url
  validates :social_media_id, :account_name, :account_url, presence: true
  
  belongs_to :social_media
  belongs_to :networkable, polymorphic: true
  
end
