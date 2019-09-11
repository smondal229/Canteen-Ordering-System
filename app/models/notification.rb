class Notification < ApplicationRecord
  belongs_to :notifiable, polymorphic: true

  scope :read, -> { update(read: true) }
  
  after_create_commit {
    channel = "#{self.notifiable_type}#{self.notifiable_id}:notifications_channel"

    ActionCable.server.broadcast(channel,{
      notification: ApplicationController.renderer.render(partial: "notifications/notification", locals: { notification: self })
    })
  }

  def self.get_datetime
    self.created_at..to_formatted_s(:short)
  end

end
