class AddDoneToPlans < ActiveRecord::Migration
  def change
    add_column :plans, :done, :boolean, default: false
  end
end
