class Notification < ApplicationRecord
  belongs_to :notifiable, polymorphic: true

  after_create_commit {
    channel = "#{self.notifiable_type}#{self.notifiable_id}:notifications_channel"
    puts channel
    ActionCable.server.broadcast(channel,{
      notification: ApplicationController.renderer.render(partial: "notifications/notification", locals: { notification: self })
    })
  }

end
