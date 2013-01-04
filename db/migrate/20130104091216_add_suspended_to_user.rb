class AddSuspendedToUser < ActiveRecord::Migration
  def up
    add_column :users, :suspended, :boolean, :default => false
  end

  def down
    remove_column :users, :suspended
  end
  
end
