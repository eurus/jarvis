class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new
    can :project_logs, :all

    if user.username == 'anna'
      can :groups, :all
      can :users, :all
      can :errands, :all
      can :projects, :all
      can :vacations, :all
      can :check, :all
    end

    if user.pm? or user.director? or user.ceo?
      can :users, :all
      can :groups, :all
      can :projects, :all
    end

    if user.ceo? or user.director?
      can :overtimes, :all
      can :errands, :all
      can :vacations, :all
      can :check, :all
      can :issue, :all
    end

  end
end
