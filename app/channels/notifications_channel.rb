class NotificationsChannel < ApplicationCable::Channel
  def subscribed
    stream_from "#{params[:class]}#{params[:id]}:notifications_channel"
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end
end
