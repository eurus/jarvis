class ChangeIdsToIdArrayInGroups < ActiveRecord::Migration
  def change
    remove_column :groups, :ids
    add_column :groups, :id_array, :text
  end
end
