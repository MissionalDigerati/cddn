class CreateEvents < ActiveRecord::Migration
  def self.up
    create_table :events do |t|
      t.string :title
      t.text :details
      t.string :address_1
      t.string :address_2
      t.string :city_province
      t.integer :state_id
      t.integer :country_id
      t.string :zip_code
      t.boolean :online_event, default: false
      t.string :longitude
      t.string :latitude
      t.timestamps
    end
  end
  
  def self.down
    drop_table :events
  end
end