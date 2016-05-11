class ChangeStatusInPlans < ActiveRecord::Migration
  def change
    change_column :plans, :status, :string, default: 'ongoing'
  end
end
