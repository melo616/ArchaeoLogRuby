class ArtifactPolicy < ApplicationPolicy
  attr_reader :user, :artifact

  def initialize(user, artifact)
    @user = user
    @artifact = artifact
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
    lead? || poster?
  end

  def destroy?
    lead? || poster?
  end


  private

  def participant?
    @artifact.dig.dig_participants.include?(user)
  end

  def lead?
    @artifact.dig.leads.include?(user)
  end

  def poster?
    @artifact.poster == user
  end

end
