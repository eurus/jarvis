class Vacation < ActiveRecord::Base
  belongs_to :user
  validates :duration, numericality: { greater_than_or_equal_to: 0.5}
  validates :start_at, :duration, :cut, :content, :user_id, presence: true
  paginates_per 10
  belongs_to :approve_by, foreign_key:'approve_by_id', class_name: 'User'

  def status_explain
    if approve
      if approve_time
        "#{approve_time.strftime('%Y-%m-%d')}  ▪ #{approve_by_username}"
      else
        ""
      end
    else
      ""
    end
  end

  default_scope {order(approve: :asc)}
end
