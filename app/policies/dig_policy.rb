class DigPolicy < ApplicationPolicy
  attr_reader :user, :dig

  def initialize(user, dig)
    @user = user
    @dig = dig
  end

  def index?
    true
  end

  #user can only see dig if they are a participant
  def show?
    @dig.users.include?(user)
  end

  def can_see_date?
    # is_dig_leader?
  end
end
