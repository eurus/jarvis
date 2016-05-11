class AddRealnameToUsers < ActiveRecord::Migration
  def change
    add_column :users, :realname, :string
    remove_column :users, :role
    add_column :users, :gender, :string
    add_column :users,:occupation, :string
  end
end
