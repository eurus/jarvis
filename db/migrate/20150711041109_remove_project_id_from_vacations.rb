class RemoveProjectIdFromVacations < ActiveRecord::Migration
  def change
    remove_column :vacations, :project_id
  end
end
