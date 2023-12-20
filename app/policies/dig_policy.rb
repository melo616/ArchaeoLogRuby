class DigPolicy < ApplicationPolicy
  attr_reader :user, :dig
# Looks great!
  def initialize(user, dig)
    @user = user
    @dig = dig
  end

  def index?
    true
  end

  def show?
    participant?
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

  def show_data_charts?
    lead? || analyst?
  end

  private

  def participant?
    @dig.dig_participants.any? { |participant| participant.participant_id == user.id }
  end

  def lead?
    @dig.leads.include?(user)
  end

  def analyst?
    @dig.dig_participants.find_by(participant_id: user.id).role == "analyst"
  end
end
