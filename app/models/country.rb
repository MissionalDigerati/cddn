class Country < ActiveRecord::Base
  
  has_many :users
  has_many :events

  attr_accessible :iso, :iso3, :name, :numcode, :printable_name

  def self.country_drop_down
    Country.all.collect {|c| [c.printable_name, c.id]}
  end

end
