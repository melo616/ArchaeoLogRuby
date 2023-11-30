class ProfilesController < ApplicationController
  before_action :set_profile

  def show
    authorize(@profile, policy_class: ProfilePolicy)
  end

  private

  def set_profile
    @profile = User.find(params[:id])
  end

end
