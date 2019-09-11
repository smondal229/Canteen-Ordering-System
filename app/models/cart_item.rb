class CartItem < ApplicationRecord
  belongs_to :food
  belongs_to :cart
  
  validates :quantity, null: false, presence: true, numericality: { only_integer: true, greater_than: 0 }
end
