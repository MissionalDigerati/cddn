class Country < ActiveRecord::Base
  attr_accessible :iso, :iso3, :name, :numcode, :printable_name
  has_many :users
  has_many :events

  def self.country_drop_down
    Country.all.collect {|c| [c.printable_name, c.id]}
  end

end
