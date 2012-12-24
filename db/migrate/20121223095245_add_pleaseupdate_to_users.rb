class AddPleaseupdateToUsers < ActiveRecord::Migration
  def up
    add_column :users, :please_update, :boolean, :default => false
  end
  
  def down
    remove_column :users, :please_update
  end
end
