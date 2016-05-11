class AddUserNumberToUsers < ActiveRecord::Migration
  def change
    add_column :users, :user_number, :string
  end
end
