class AddApprovedEventToUsers < ActiveRecord::Migration
  def self.up
    add_column :users, :event_approved, :boolean, :default => false
  end
  
  def self.down
    remove_column :users, :event_approved
  end
end
