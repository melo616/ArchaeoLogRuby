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
    participant?
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

  def get_dig(image)
    debugger
    if image.imageable_type == "Dig"
      dig = Dig.find_by(id: image.imageable_id)
    elsif image.imageable_type == "Artifact"
      artifact = Artifact.find_by(id: image.imageable_id)
      dig = Dig.find_by(id: artifact.dig_id)
    end
  end

  def participant?
    dig = get_dig(@image)
    dig.dig_participants.any? { |participant| participant.participant_id == user.id }
  end

  def lead?
    dig = get_dig(@image)
    dig.leads.include?(user)
  end

  def poster?
    @image.poster == user
  end

end
