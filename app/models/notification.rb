class Notification < ApplicationRecord
  belongs_to :notifiable, polymorphic: true
  
  after_create_commit {
    channel = "#{self.notifiable_type}#{self.notifiable_id}:notifications_channel"

    ActionCable.server.broadcast(channel,{
      notification: ApplicationController.renderer.render(partial: "notifications/notification", locals: { notification: self })
    })
  }

  scope :order_desc, -> { order(created_at: :desc) }

  def notified
    update(read: true)
  end

  def get_datetime
    created_at.to_formatted_s(:short)
  end

end
