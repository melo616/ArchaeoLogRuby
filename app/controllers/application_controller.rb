class ApplicationController < ActionController::Base
  before_action :authenticate_user!, except: [:about]
  skip_forgery_protection
  include Pundit::Authorization
  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized
  after_action :verify_authorized, unless: :devise_controller?
  before_action :configure_permitted_parameters, if: :devise_controller?
  # after_action :verify_policy_scoped, only: :index, unless: :devise_controller?

  protected
  #accepts additional user parameters
  def configure_permitted_parameters
      devise_parameter_sanitizer.permit(:sign_up) { |u| u.permit(:first_name, :last_name, :bio, :email, :password)}

      devise_parameter_sanitizer.permit(:account_update) { |u| u.permit(:first_name, :last_name, :bio, :email, :password, :current_password)}
  end

  private

  def user_not_authorized
    flash[:alert] = "You are not authorized to perform this action."
    redirect_back fallback_location: root_url
  end
end
