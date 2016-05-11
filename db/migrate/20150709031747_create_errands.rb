class CreateErrands < ActiveRecord::Migration
  def change
    create_table :errands do |t|
      t.string :location
      t.string :content
      t.timestamp :start_at
      t.timestamp :end_at
      t.integer :project_id
      t.integer :user_id
      t.float :fee
      t.boolean :check
      t.boolean :issue

      t.timestamps null: false
    end
  end
end
