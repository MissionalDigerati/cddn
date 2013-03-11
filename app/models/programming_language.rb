class ProgrammingLanguage < ActiveRecord::Base
  attr_accessible :language
  # has_many :programmings, dependent: :destroy
  has_many :programmings, dependent: :destroy
  has_many :users, through: :programmings, source: :programmable, source_type: "User"
  has_many :events, through: :programmings, source: :programmable, source_type: "Event"
  has_many :projects, through: :programmings, source: :programmable, source_type: "Project"
  
  validates :language, presence: true

end
