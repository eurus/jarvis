class CreateBugHunters < ActiveRecord::Migration
  def change
    create_table :bug_hunters do |t|
      t.string :project_name
      t.text :trace

      t.timestamps null: false
    end
  end
end
