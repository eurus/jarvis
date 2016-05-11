class AddColumnsToVacations < ActiveRecord::Migration
  def change
    add_column :vacations, :project_id, :integer
    add_column :vacations, :user_id, :integer
    add_column :vacations, :approve, :boolean
  end
end
