class RemoveOccupationAddRank < ActiveRecord::Migration
  def change
    remove_column :users, :occupation
    add_column :users, :rank, :string
  end
end
