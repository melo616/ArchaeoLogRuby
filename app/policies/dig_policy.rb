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

  def edit?
    update?
  end

  def update?
    lead?
  end

  def destroy?
    lead?
  end

  def can_see_date?
    # is_dig_leader?
  end

  private

  def lead?
    dig.leads.any? { |lead| lead.participant_id == user.id }
  end
end
