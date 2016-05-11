class AddApproveByAndIssueBy < ActiveRecord::Migration
  def change
    add_column :errands, :approve_by_username, :string
    add_column :errands, :issue_by_username, :string
    add_column :overtimes, :approve_by_username, :string
    add_column :overtimes, :issue_by_username, :string
    add_column :vacations, :approve_by_username, :string
  end
end
