class NotificationsController < ApplicationController

  def update
    @notification = Notification.find(params[:id])

    respond_to do |format|
      if @notification.notified
        format.js
      end
    end
  end

end
