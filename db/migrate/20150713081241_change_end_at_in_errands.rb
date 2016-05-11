class ChangeEndAtInErrands < ActiveRecord::Migration
  def change
    change_column :errands, :end_at, :date
  end
end
