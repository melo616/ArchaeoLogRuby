class InvitationPolicy < ApplicationPolicy
  attr_reader :user, :invitation

  def initialize(user, invitation)
    @user = user
    @invitation = invitation
  end

  def index?
    true
  end

  def create?
    true
  end

  def accept?
    recipient?
  end

  def destroy?
    sender?
  end

  private

  def recipient?
    invitation.recipient == user
  end

  def sender?
    invitation.sender == user
  end
end
