class ChangeColumnInPlans < ActiveRecord::Migration
  def change
    change_column :plans, :status, :string, default: 'notbegin'
    add_column :plans, :done_at, :date
  end
end
