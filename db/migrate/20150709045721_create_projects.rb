class CreateProjects < ActiveRecord::Migration
  def change
    create_table :projects do |t|
      t.string :name
      t.string :content
      t.integer :owner
      t.string :status

      t.timestamps null: false
    end
  end
end
