class AddCreatorIdToPlans < ActiveRecord::Migration
  def change
    add_column :plans, :creator_id, :integer
  end
end
