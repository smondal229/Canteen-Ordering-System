class Message < ApplicationRecord
  belongs_to :sendable, polymorphic: true
  belongs_to :recipientable, polymorphic: true

  validates :body, null: false, presence: true

end
