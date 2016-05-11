class CreateVacations < ActiveRecord::Migration
  def change
    create_table :vacations do |t|
      t.timestamp :start_at
      t.float :duration
      t.string :type
      t.string :content

      t.timestamps null: false
    end
  end
end
