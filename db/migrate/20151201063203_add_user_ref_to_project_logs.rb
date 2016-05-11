class AddUserRefToProjectLogs < ActiveRecord::Migration
  def change
    add_reference :project_logs, :user, index: true, foreign_key: true
  end
end
