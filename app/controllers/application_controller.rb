class ApplicationController < ActionController::Base
  before_action :current_user

  def current_user
    @_current_user = session[:current_user_id]
  end
end
