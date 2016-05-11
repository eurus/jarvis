class AddTimeToTables < ActiveRecord::Migration
  def change
    add_column :overtimes, :approve_time, :date
    add_column :overtimes, :issue_time, :date
    add_column :errands, :approve_time, :date
    add_column :errands, :issue_time, :date
    add_column :vacations, :approve_time, :date
    add_column :vacations, :issue_time, :date
  end
end
