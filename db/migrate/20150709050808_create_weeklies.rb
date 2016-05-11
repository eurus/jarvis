class CreateWeeklies < ActiveRecord::Migration
  def change
    create_table :weeklies do |t|
      t.integer :user_id
      t.text :sumary
      t.text :hope

      t.timestamps null: false
    end
  end
end
