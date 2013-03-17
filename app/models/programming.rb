class Programming < ActiveRecord::Base
  
  belongs_to :programming_language
  belongs_to :programmable, polymorphic: true
  
  attr_accessible :programming_language_id, :programming_language_ids
  
  validates :programming_language_id, :programmable_id, :programmable_type, presence: true
end
