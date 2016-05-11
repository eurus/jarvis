class CreateProjectLogs < ActiveRecord::Migration
  def change
    create_table :project_logs do |t|
      t.timestamp :time
      t.string :type
      t.text :content
      t.references :project, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
