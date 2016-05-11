class ProjectLog < ActiveRecord::Base
  belongs_to :project
  CATEGORY_LIST = ['变更', '记录',  '里程碑','风险','款项','反馈']
  default_scope {order(date: :desc)}
  belongs_to :user
end
