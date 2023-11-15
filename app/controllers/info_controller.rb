class InfoController < ApplicationController
  before_action :skip_authorization
  
  def about
    render "about"
  end
end
