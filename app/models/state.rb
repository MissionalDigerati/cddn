class State < ActiveRecord::Base
  attr_accessible :state_long, :state_short
  has_many :users
  has_many :events

  def self.state_drop_down
    State.all.collect {|s| [s.state_long, s.id]}
  end

end
