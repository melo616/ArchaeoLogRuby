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
    poster?
  end

  def update?
    poster?
  end

  def destroy?
    lead? || poster?
  end


  private

  def lead?
    # @artifact.dig.leads.any? { |lead| lead[:participant_id] == @user.id }
    # pp "Checked lead"
    @artifact.dig.leads.include?(user)
  end

  def poster?
    @artifact.poster == user
    pp "Checked poster"
  end

end
