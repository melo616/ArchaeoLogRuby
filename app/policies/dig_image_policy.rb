class ArtifactPolicy < ApplicationPolicy
  attr_reader :user, :dig_image

  def initialize(user, dig_image)
    @user = user
    @dig_image = dig_image
  end

  def index?
    true
  end

  def show?
    true
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
    true
  end

  def destroy?
    true
  end


  private

  def participant?
    @dig_image.dig.dig_participants.any? { |participant| participant.participant_id == user.id }
  end

  def lead?
    @dig_image.dig.leads.any? { |lead| lead.participant_id == user.id }
  end

  def poster?
    @dig_image.poster == user
  end

end
