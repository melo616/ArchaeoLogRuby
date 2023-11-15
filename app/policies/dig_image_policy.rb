class DigImagePolicy < ApplicationPolicy
  attr_reader :user, :dig_image

  def initialize(user, dig_image)
    @user = user
    @dig_image = dig_image
  end

  def index?
    true
  end

  def show?
    participant?
  end

  def new?
    create?
  end

  def create?
    true
  end

  def edit?
    update?
  end

  def update?
    poster? || lead?
  end

  def destroy?
    poster? || lead?
  end


  private

  def participant?
    @dig_image.dig.dig_participants.any? { |participant| participant.participant_id == user.id }
  end

  def lead?
    @dig_image.dig.leads.any? { |lead| lead.participant_id == user.id }
  end

  def poster?
    @dig_image.user == user
  end

end
