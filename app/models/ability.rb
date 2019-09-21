class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User::User.new

    # Define user abilities
    if user.isAdmin
      can :manage, Registry::Employee
    end
  end
end
