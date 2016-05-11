class AddDoneAtToProjects < ActiveRecord::Migration
  def change
    add_column :projects, :done_at, :date
  end
end
