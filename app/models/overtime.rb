class Overtime < ActiveRecord::Base
  belongs_to :user
  belongs_to :project
  validates :start_at, :duration, :content,presence: true
  validates :duration, numericality: { greater_than_or_equal_to: 0.5}
  paginates_per 10
  belongs_to :approve_by, foreign_key:'approve_by_id', class_name: 'User'
  belongs_to :issue_by, foreign_key:'issue_by_id', class_name: 'User'
  def status_explain
    if issue
      if issue_time
        "#{issue_time.strftime('%Y-%m-%d')}  ▪ #{issue_by_username}"
      else
        ""
      end
    elsif approve
      if approve_time
        "#{approve_time.strftime('%Y-%m-%d')}  ▪ #{approve_by_username}"
      else
        ""
      end
    else
      ""
    end
  end


  default_scope {order(approve: :asc, issue: :asc)}
end
