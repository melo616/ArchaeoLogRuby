class ProfilePolicy < ApplicationController
  attr_reader :user, :profile

  def initialize(user, profile)
    @user = user
    @profile = profile
  end

  def show?
    true
  end

end
