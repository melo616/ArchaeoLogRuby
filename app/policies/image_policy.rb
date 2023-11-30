class ImagePolicy < ApplicationPolicy
  attr_reader :user, :image

  def initialize(user, image)
    @user = user
    @image = image
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
    @image.dig.dig_participants.any? { |participant| participant.participant_id == user.id }
  end

  def lead?
    @image.dig.leads.any? { |lead| lead == user }
  end

  def poster?
    @image.poster == user
  end

end
