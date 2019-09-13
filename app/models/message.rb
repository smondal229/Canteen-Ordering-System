class Message < ApplicationRecord
  belongs_to :sendable,      polymorphic: true
  belongs_to :recipientable, polymorphic: true

  validates :body, null: false, presence: true

  scope :find_recipientable, ->(user) { where(recipientable: user) }
  scope :find_sendable, ->(user) { where(sendable: user) }
  scope :order_desc, -> { order(created_at: :desc) }
  
  def get_datetime
    created_at.to_formatted_s(:long)
  end
  
end
