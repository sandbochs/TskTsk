class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new # guest user (not logged in)
    can :manage, List, user_id: user.id
    can :manage, Todo, user_id: user.id
  end
end
