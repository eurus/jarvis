class CreateArticals < ActiveRecord::Migration
  def change
    create_table :articals do |t|
      t.string :title
      t.text :content
      t.integer :user_id
      t.string :origin

      t.timestamps null: false
    end
  end
end
