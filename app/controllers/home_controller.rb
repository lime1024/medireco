class HomeController < ApplicationController
  skip_before_action :login_required
  
  def index
    redirect_to medical_bills_path if current_user
  end

  def policy
  end

  def disclaimer
  end
end
