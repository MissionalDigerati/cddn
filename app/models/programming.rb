class Programming < ActiveRecord::Base
  attr_accessible :programming_language_id, :programming_language_ids
  belongs_to :programming_languages
  belongs_to :programmable, polymorphic: true
end