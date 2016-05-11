class ChangePlanStatusToCh < ActiveRecord::Migration
  def change
    change_column :plans, :status, :string, default:'未开始'
  end
end
