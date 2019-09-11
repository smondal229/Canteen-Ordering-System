class FoodStore < ApplicationRecord

  has_many :chefs, dependent: :nullify
  has_many :foods, dependent: :destroy
  has_many :food_galleries, dependent: :destroy
  has_many :carts, dependent: :nullify
  
  validates :name, presence: true, null: false, uniqueness: { case_sensitive: false }

end
