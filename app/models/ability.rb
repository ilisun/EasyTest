class Ability
  include CanCan::Ability
  attr_reader :user

  def initialize(user)
    @user = user

    if user
      user.admin? ? admin_abilities : user_abilities
    else
      guest_abilities
    end
  end

  def guest_abilities
    can :read, :all
  end

  def admin_abilities
    can :manage, :all
  end

  def user_abilities
    guest_abilities
    can :create, [Post, Comment]
    can [:edit, :update, :destroy], [Post, Comment], user: user
    can [:my_posts], [Post], user: user
  end
end
