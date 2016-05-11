class ChangeTypeToCategory < ActiveRecord::Migration
  def change
    rename_column :project_logs, :type, :category
    change_column :project_logs, :time, :date
    rename_column :project_logs, :time, :date
  end
end
