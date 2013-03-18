class Network < ActiveRecord::Base
  
  belongs_to :social_media
  belongs_to :networkable, polymorphic: true

  attr_accessible :social_media_id, :account_name, :account_url, :social_media_name
  validates :social_media_id, :account_name, :account_url, presence: true
  

  #getter
  def social_media_name
    social_media_id.try(:service)
  end

  #setter
  def social_media_name=(service)
    self.social_media_id = SocialMedia.find_by_service(service) if service.present?
  end
end
