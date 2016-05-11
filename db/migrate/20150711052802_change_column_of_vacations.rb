class ChangeColumnOfVacations < ActiveRecord::Migration
  def change
    change_column :vacations, :start_at,  :date
    change_column :errands, :start_at,  :date
    change_column :overtimes, :start_at,  :date
  end
end
