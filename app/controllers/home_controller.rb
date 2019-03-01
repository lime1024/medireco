class HomeController < ApplicationController
  skip_before_action :login_required
  
  def index
    render layout: nil
  end
end
