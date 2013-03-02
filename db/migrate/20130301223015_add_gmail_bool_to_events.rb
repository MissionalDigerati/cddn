class AddGmailBoolToEvents < ActiveRecord::Migration
  def up
    add_column :events, :gmaps, :boolean, default: false
  end
  
  def down
    remove_column :events, :gmaps
  end
end
