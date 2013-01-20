class CreateNetworks < ActiveRecord::Migration
  def change
    create_table :networks do |t|
      t.integer :social_media_id
      t.string :account_name
      t.string :account_url
      t.belongs_to :networkable, polymorphic: true
      t.timestamps
    end
    add_index :networks, [:networkable_id, :networkable_type]
  end
end
