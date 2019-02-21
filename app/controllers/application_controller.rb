class ApplicationController < ActionController::Base
  helper_method :current_user
  before_action :login_required

  private

  def current_user
    if session[:user_id]
      @current_user ||= User.find_by(id: session[:user_id])
    end
  end

  def login_required
    unless current_user
      redirect_to login_path 
    end
  end
end
