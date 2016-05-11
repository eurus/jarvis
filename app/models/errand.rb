class Errand < ActiveRecord::Base
  belongs_to :user
  belongs_to :project
  validates :content, :start_at, :end_at, :project_id,:user_id, presence: true
  validate :end_should_greater_than_start
  paginates_per 10

  scope :this_year, -> {where(created_at: Time.current.beginning_of_year..Time.current.end_of_year)}
  default_scope {order(approve: :asc, issue: :asc)}

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

  private
  def end_should_greater_than_start
    if self.end_at <  self.start_at
      errors.add("结束时间", "并不能比开始时间小")
    end
  end

end
