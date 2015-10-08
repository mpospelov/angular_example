class AddPreferredWorkingHourPerDayToUsers < ActiveRecord::Migration
  def change
    add_column :users, :preferred_working_hours_per_day, :integer, default: 8
  end
end
