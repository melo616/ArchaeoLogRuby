class DocumentPolicy < ApplicationPolicy
  attr_reader :user, :document

  def initialize(user, document)
    @user = user
    @document = document
  end

  def index?
    true
  end

  def show?
    allowed_role?
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
    lead? || poster?
  end

  def destroy?
    lead? || poster?
  end

  private

  def participant?
    @document.dig.dig_participants.any? { |participant| participant.participant_id == user.id }
  end

  def lead?
    @document.dig.leads.any? { |lead| lead.participant_id == user.id }
  end

  def poster?
    @document.poster == user
  end

  def allowed_role?
    user_role = @document.dig.dig_participants.find_by(participant_id: user.id)&.role
    @document.allowed_roles.include?(user_role)
  end
end
