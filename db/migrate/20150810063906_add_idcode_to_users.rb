class AddIdcodeToUsers < ActiveRecord::Migration
  def change
    add_column :users, :idcode, :string
    add_column :users, :constellation, :string
  end
end
