class HomeController < ApplicationController
  skip_before_action :login_required
  
  def index
  end

  def policy
  end

  def disclaimer
  end
end
