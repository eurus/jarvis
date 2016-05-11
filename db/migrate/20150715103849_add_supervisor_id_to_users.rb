class AddSupervisorIdToUsers < ActiveRecord::Migration
  def change
    add_column :users, :supervisor_id, :integer
  end
end
