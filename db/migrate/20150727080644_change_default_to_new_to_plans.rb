class ChangeDefaultToNewToPlans < ActiveRecord::Migration
  def change
    change_column :plans, :status, :string, default: 'new'
  end
end
