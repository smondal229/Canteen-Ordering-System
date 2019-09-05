class Chef < ApplicationRecord

  has_secure_password
  
  belongs_to :food_store, optional: true

  has_many :notifications, as: :notifiable, dependent: :destroy
  has_many :messages, as: :sendable, dependent: :destroy
  has_many :messages, as: :recipientable, dependent: :destroy

  before_save { self.name = self.name.to_s.titlecase }
  before_save { self.email = self.email.to_s.downcase }
  
  EMAIL_REGEX = /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,4})\z/i
  validates :email, presence: true, uniqueness: { case_sensitive: false }, format: { with: EMAIL_REGEX }
  validate :cannot_approve_without_food_store, on: :update

  
  def cannot_approve_without_food_store
    if food_store.nil? && !approved.nil?
      errors[:base] << "The chef does not have any food store"
    end
  end

  def update_from_omniauth(auth)
    self.provider = auth.provider
    self.uid = auth.uid
    self.name = auth.info.name
    self.oauth_token = auth.credentials.token
    self.oauth_expires_at = Time.at(auth.credentials.expires_at)
    self.save!
  end

end
