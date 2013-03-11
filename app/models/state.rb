class State < ActiveRecord::Base
  attr_accessible :state_long, :state_short
  has_many :users
  has_many :events

  def self.state_drop_down
    State.all.collect {|s| [s.state_long, s.id]}
  end

  def self.display_state_name(state_id)
    state_id.present? ? State.find(state_id).state_long : ""
  end

end
