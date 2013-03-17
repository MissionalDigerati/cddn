class Network < ActiveRecord::Base
  
  belongs_to :social_media
  belongs_to :networkable, polymorphic: true

  attr_accessible :social_media_id, :account_name, :account_url
  validates :social_media_id, :account_name, :account_url, presence: true
  
end
