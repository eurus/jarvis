class AddIdsToGroups < ActiveRecord::Migration
  def change
    add_column :groups, :ids, :text
    remove_column :groups, :leader_role
  end
end
