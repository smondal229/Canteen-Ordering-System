class NotificationsController < ApplicationController

  def update
    @notification = Notification.find(params[:id])

    respond_to do |format|
      if @notification.update(read: true)
        format.js
      end
    end
  end

end
