class ArtifactPolicy < ApplicationPolicy
  attr_reader :user, :artifact

  def initialize(user, artifact)
    @user = user
    @artifact = artifact
  end

  def index?
    # TODO: need to know the dig
    true
  end

  def show?
    true
  end

  def new?
    true
  end

  def create?
    true
  end

  def edit?
    lead? || poster?
  end

  def update?
    lead? || poster?
  end

  def destroy?
    lead? || poster?
  end


  private

  def lead?
    @artifact.dig.leads.any? { |lead| lead[:participant_id] == @user.id }
  end

  def poster?
    @user == @artifact.poster
  end

end
