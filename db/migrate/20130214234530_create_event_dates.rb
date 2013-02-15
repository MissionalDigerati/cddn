class CreateEventDates < ActiveRecord::Migration
  def change
    create_table :event_dates do |t|
      t.integer :event_id
      t.date :date_of_event
      t.time :time_of_event
      t.timestamps
    end
  end
end
