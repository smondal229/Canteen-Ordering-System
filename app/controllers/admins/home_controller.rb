class Admins::HomeController < ApplicationController
  skip_before_action :set_notification_badge
  before_action :authenticate_admin
  
  def index
  end

end