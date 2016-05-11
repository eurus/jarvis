class ChangeColumnInErrands < ActiveRecord::Migration
  def change
    rename_column :errands, :check, :approve
  end
end
