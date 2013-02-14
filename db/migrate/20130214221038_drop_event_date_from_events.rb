class DropEventDateFromEvents < ActiveRecord::Migration
  def up
    remove_column :events, :event_date
  end

  def down
    add_column :events, :event_date, :date
  end
end
