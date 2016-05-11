class ChangeDatetimeToDateInUsers < ActiveRecord::Migration
  def change
    change_column :users, :join_at, :date
    change_column :users, :leave_at, :date
  end
end
