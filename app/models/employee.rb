class Employee < ApplicationRecord

  has_secure_password
  
  belongs_to :company, optional: true

  has_many :carts,                              dependent: :destroy
  has_many :notifications,  as: :notifiable,    dependent: :destroy
  has_many :messages,       as: :sendable,      dependent: :destroy
  has_many :messages,       as: :recipientable, dependent: :destroy

  before_save { self.name = self.name.to_s.titlecase }
  before_save { self.email = self.email.to_s.downcase }

  EMAIL_REGEX = /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,4})\z/i
  validates :email, null: false, presence: true, uniqueness: { case_sensitive: false }, format: { with: EMAIL_REGEX }
  validate :cannot_approve_without_company, on: :update

  scope :only_approved,   -> { where(approved: true) }

  def approve_access
    update(approved: true)
  end

  def reject_access
    update(approved: false)
  end

  def cannot_approve_without_company
    if company.nil? && !approved.nil?
      errors[:base] << "The employee does not have any company"
    end
  end

  def update_from_omniauth(auth)
    self.provider = auth.provider
    self.uid = auth.uid
    self.name = auth.info.name
    self.oauth_token = auth.credentials.token
    self.oauth_expires_at = Time.at(auth.credentials.expires_at)
    self.save
  end
end
