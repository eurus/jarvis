class RemoveTypeFromVacations < ActiveRecord::Migration
  def change
    remove_column :vacations, :type
    add_column :vacations, :cut, :string
  end
end
