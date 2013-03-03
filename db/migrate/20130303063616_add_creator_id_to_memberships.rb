class AddCreatorIdToMemberships < ActiveRecord::Migration
  def up
    add_column :memberships, :creator_id, :integer
  end
  
  def down
    remove_column :memberships, :creator_id
  end
end
