class Feedback < ActiveRecord::Base
  belongs_to :user
  validates :content, presence: true
  paginates_per 10
end
