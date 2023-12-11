class DigParticipantPolicy < ApplicationPolicy
  attr_reader :user, :dig_participant

  def initialize(user, dig_participant)
    @user = user
    @dig_participant = dig_participant
  end

  def index?
    # TODO: need to know the dig
    true
  end

  def new?
    lead?
  end

  def create?
    # lead?
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
