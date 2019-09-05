class Status < ApplicationRecord

  has_many :carts
  
  validates :name, null: false, uniqueness: { case_sensitive: false }
end
