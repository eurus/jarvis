class Project < ActiveRecord::Base
  validates :name, :content, :status, presence: true
  paginates_per 10
  has_and_belongs_to_many :users
  has_many :project_logs
  belongs_to :owner, class_name:'User'
  has_many :errands

  attr_accessor :current_user

  STATUS_LIST = ["启动", "规划", "执行", "收尾", "结束", "维护", "中止"]

  after_update :status_change, :if => :status_changed?
  before_update :status_done_at

  def status_done_at
    if self.status == '结束'
      self.done_at = Date.today
    end
  end

  def status_change
    pl = ProjectLog.new(date: Date.today, project:self, user:self.current_user, category: '记录',
      content: "项目状态变更为： #{self.status}")
    pl.save
  end

  def self.done
    where(status: "done",
      created_at: Time.current.beginning_of_year..Time.current.end_of_year)
  end

  def status_explain
    # dict = {done: '完成', :'on going'=>'进行中', :'blue print'=> '计划', pause:'暂停', maintainning:'维护中'}
    # dict[status.to_sym]
    status
  end

  def status_class
    dict = {:'收尾'=> 'info', :'执行'=>'success', :'规划'=> 'warning', :'中止'=>'danger', :'启动'=>'', :'维护'=>'', :'结束'=>''}
    dict[status.to_sym]
  end

  def status_no
    dict = {:'启动'=>1, :'规划'=> 2, :'执行'=>3, :'收尾'=> 4, :'中止'=>6, :'维护'=>5, :'结束'=>99}
    dict[status.to_sym]
  end

  def errand_total
    total = if errands.length > 0 then errands.map(&:fee).reduce(:+) if errands else 0 end
    (total * 100).to_i / 100.0
    end

    def include_uid?(user_id)
      (users.map(&:id) + [owner_id]).include? user_id
    end

  end
