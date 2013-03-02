class ChangeLatLongToFloat < ActiveRecord::Migration
  def up
    change_column :events, :longitude, :float
    change_column :events, :latitude, :float
  end

  def down
    change_column :events, :longitude, :string
    change_column :events, :latitude, :string
  end
end
