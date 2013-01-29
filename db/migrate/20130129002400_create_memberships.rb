class CreateMemberships < ActiveRecord::Migration
  def change
    create_table :memberships do |t|
      t.integer :user_id
      t.integer :project_id
      t.string :status
      t.string :role
      t.timestamps
    end
  end
end
