class CreateAttendees < ActiveRecord::Migration
  def self.up
    create_table :attendees do |t|
      t.integer :user_id
      t.integer :event_id
      t.string :attendee_type
      t.timestamps
    end
  end
  
  def self.down
    drop_table :attendees
  end
  
end
