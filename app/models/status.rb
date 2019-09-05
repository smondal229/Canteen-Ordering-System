class Status < ApplicationRecord

  has_many :carts
  
  validates :name, null: false, presence: true, uniqueness: { case_sensitive: false }
end
