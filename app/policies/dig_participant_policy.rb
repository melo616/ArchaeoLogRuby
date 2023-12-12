class DigParticipantPolicy < ApplicationPolicy
  attr_reader :user, :dig_participant

  def initialize(user, dig_participant)
    @user = user
    @dig_participant = dig_participant
  end

  def index?
    true
  end

  def new?
    lead?
  end

  def create?
    true
  end

  def edit?
    lead?
  end

  def update?
    lead?
  end

  def destroy?
    lead?
  end

  private

  def lead?
    @dig_participant.dig.leads.include?(user)
  end
end
