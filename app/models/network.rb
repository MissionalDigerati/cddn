class Network < ActiveRecord::Base
  
  belongs_to :social_media
  belongs_to :networkable, polymorphic: true

  attr_accessible :social_media_id, :account_name, :account_url
  validates :social_media_id, :account_name, :account_url, presence: true
  

  #getter
  def social_media_name
    social_media.try(:service)
  end

  #setter
  def social_media_name=(name)
    self.social_media = SocialMedia.find_by_service(name) if name.present?
  end
end
