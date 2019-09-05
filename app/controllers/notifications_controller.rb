class NotificationsController < ApplicationController
  before_action :set_user
  def index
    @notification = Notification.where(notifiable: @user).order("created_at DESC")
  end

  private
    def set_user
      @notifiable_type, @notifiable_id = request.path.split("/")[1,2]
      @notifiable_class = @notifiable_type.to_s.classify
      
      if @sendable_class == "Employee"
        authenticate_employee
        @user = current_employee
      elsif @sendable_class == "Chef"
        authenticate_chef
        @user = current_chef
      end
    end
end
