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
    if @image.imageable_type == "Dig"
      dig = Dig.find_by(id: @image.imageable_id)
    elsif @image.imageable_type == "Artifact"
      artifact = Artifact.find_by(id: @image.imageable_id)
      dig = Dig.find_by(id: artifact.dig_id)
    end
    dig.dig_participants.any? { |participant| participant.participant_id == user.id }
  end

  def lead?
    if @image.imageable_type == "Dig"
      dig = Dig.find_by(id: @image.imageable_id)
    elsif @image.imageable_type == "Artifact"
      artifact = Artifact.find_by(id: @image.imageable_id)
      dig = Dig.find_by(id: artifact.dig_id)
    end
    dig.leads.any? { |lead| lead == user }
  end

  def poster?
    @image.poster == user
  end

end
