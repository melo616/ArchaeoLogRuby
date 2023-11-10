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

  private

  def lead?
    @dig_participant.dig.leads.any? { |lead| lead[:participant_id] == @user.id }
    # @dig_participant.dig.leads.any? { |dig_participant| dig_participant.participant = @user }
  end
end
