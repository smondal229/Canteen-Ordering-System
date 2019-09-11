class Admin < ApplicationRecord
  has_secure_password

  validates :email, null: false, presence: true
  
end
