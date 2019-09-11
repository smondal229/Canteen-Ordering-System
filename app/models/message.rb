class Message < ApplicationRecord
  belongs_to :sendable,      polymorphic: true
  belongs_to :recipientable, polymorphic: true

  validates :body, null: false, presence: true

  scope :order_desc, -> { order("created_at desc") }
  
  def self.get_datetime
    self.created_at..to_formatted_s(:long)
  end
  
end
