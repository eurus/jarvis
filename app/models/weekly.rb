class Weekly < ActiveRecord::Base
  belongs_to :user
  validates :sumary, :hope, presence: true
  validates :hope, :sumary, length: { in: 100..80000 }
  paginates_per 10

  default_scope {order("created_at desc")}
end
