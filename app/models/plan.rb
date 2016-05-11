class Plan < ActiveRecord::Base
  validates :description,
    :status, :cut, :start_at,
    :end_at, presence: true

  validates :status,
    inclusion: { in: %w(未开始 进行中 准时 超期中 超期),
                 message: "%{value} is not a valid status" }

    validates :cut,
    inclusion: { in: %w(出差 工作),
                 message: "%{value} is not a valid type" }

    validates :description, length: {in: 40..50000}
  validate :end_should_greater_than_start
  belongs_to :user
  belongs_to :creator, class_name:'User'
  paginates_per 10
  after_create :send_it_to_supervisor

  default_scope {order("created_at desc")}

  def self.check_overtime
    Plan.where(done:false).each do |plan|
      ap "plan id #{plan.id}, this plan suppose to end at #{plan.end_at}"
      #check the plan status
      case plan.status
      when "未开始"
        plan.status = '进行中' if plan.start_at <= Date.current
        plan.status = '超期中' if plan.end_at < Date.current
      when "进行中"
        ap "current status is #{plan.status}"
        plan.status = '超期中' if plan.end_at < Date.current
      else
        ap "this record is #{plan.status}, skip"
      end
      plan.save
      if plan.status == '超期中'
        NotifyMailer.plan_overtime_warning(plan).deliver_later
      end
    end
  end

  def status_explain
    status
  end

  def status_class
    dict = {:'准时'=>'success', :'进行中'=>'info', :'未开始'=> 'default',:'超期中'=>'warning', :'超期'=>'danger'}
    dict[status.to_sym]
  end

  def diff
    if self.done_at
      return (self.end_at - self.done_at).to_i
    else
      0
    end
  end
  private
  def end_should_greater_than_start
    if self.end_at and self.start_at
      if self.end_at <  self.start_at
        errors.add("结束时间", "并不能比开始时间小")
      end

    else
      errors.add("我猜", "你肯定忘记了什么")
    end
  end

  def send_it_to_supervisor
    user = self.user
    if user.supervisor
      ids = User.ceo.map { |e| e.id }.push user.supervisor.id if user
    else
      ids = User.ceo.map { |e| e.id }
    end

    sps = User.where(id:ids)
    sps.each do |s|
      NotifyMailer.plan_maker(s, self).deliver_later
    end

    if creator and user and creator.try(:id) != user.try(:id)
      NotifyMailer.plan_assigned(user, creator, self).deliver_later
    end
  end
end
