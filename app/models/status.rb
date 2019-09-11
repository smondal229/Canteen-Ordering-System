class Status < ApplicationRecord

  has_many :carts, dependent: :nullify
  
  validates :name, null: false, presence: true, uniqueness: { case_sensitive: false }
end
