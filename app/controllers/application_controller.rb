class ApplicationController < ActionController::Base
  before_action :authenticate_user!
  skip_forgery_protection
end
