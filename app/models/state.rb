class State < ActiveRecord::Base
  attr_accessible :state_long, :state_short
  has_many :users
  has_many :events
end
