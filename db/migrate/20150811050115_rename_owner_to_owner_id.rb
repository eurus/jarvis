class RenameOwnerToOwnerId < ActiveRecord::Migration
  def change
    rename_column :projects, :owner, :owner_id
  end
end
