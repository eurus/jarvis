class AddColumnsToUsers < ActiveRecord::Migration
  def change
    add_column :users, :username, :string
    add_column :users, :nickname, :string
    add_column :users, :join_at, :timestamp
    add_column :users, :leave_at, :timestamp
  end
end
