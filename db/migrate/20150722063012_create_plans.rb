class CreatePlans < ActiveRecord::Migration
  def change
    create_table :plans do |t|
      t.string :title
      t.text :description
      t.integer :user_id
      t.string :status
      t.string :cut
      t.date :start_at
      t.date :end_at

      t.timestamps null: false
    end
  end
end
