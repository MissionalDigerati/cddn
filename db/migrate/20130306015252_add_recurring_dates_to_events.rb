class AddRecurringDatesToEvents < ActiveRecord::Migration
  def up
    add_column :events, :recurring_date, :boolean, default: false
    add_column :events, :recurring_schedule, :string
    add_column :events, :recurring_interval, :integer
  end
  
  def down
    remove_column :events, :recurring_date
    remove_column :events, :recurring_schedule
    remove_column :events, :recurring_interval
  end                                     
end
