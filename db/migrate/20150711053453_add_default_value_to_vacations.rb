class AddDefaultValueToVacations < ActiveRecord::Migration
  def change
    change_column :vacations, :approve, :boolean, default: false
    change_column :errands, :check, :boolean, default: false
    change_column :errands, :issue, :boolean, default: false
    change_column :overtimes, :approve, :boolean, default: false
    change_column :overtimes, :issue, :boolean, default: false
  end
end
