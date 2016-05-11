class CreateOvertimes < ActiveRecord::Migration
  def change
    create_table :overtimes do |t|
      t.timestamp :start_at
      t.float :duration
      t.string :content
      t.integer :user_id
      t.boolean :approve
      t.boolean :issue
      t.integer :project_id

      t.timestamps null: false
    end
  end
end
