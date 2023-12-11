class AnnouncementPolicy < ApplicationPolicy
  attr_reader :user, :announcement

  def initialize(user, announcement)
    @user = user
    @announcement = announcement
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
    lead?
  end

  def edit?
    update?
  end

  def update?
    poster?
  end

  def destroy?
    poster?
  end


  private

  def participant?
    @announcement.dig.dig_participants.any? { |participant| participant.participant_id == user.id }
  end

  def lead?
    @announcement.dig.leads.include?(user)
  end

  def poster?
    @announcement.poster == user
  end

end
