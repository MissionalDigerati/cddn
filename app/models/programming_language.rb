class ProgrammingLanguage < ActiveRecord::Base
  # attr_accessible :title, :body
  has_many :programmings
  has_many :events, through: :programmings
end
