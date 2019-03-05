class HomeController < ApplicationController
  skip_before_action :login_required
  
  def index
  end
end
