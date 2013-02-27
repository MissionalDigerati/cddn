class ProgrammingLanguage < ActiveRecord::Base
  # attr_accessible :title, :body
  # has_many :programmings, dependent: :destroy
  has_many :programmings, dependent: :destroy
  has_many :users, through: :programmings, source: :programmable, source_type: "User"
  has_many :events, through: :programmings
  
  
  validates :language, presence: true
end
