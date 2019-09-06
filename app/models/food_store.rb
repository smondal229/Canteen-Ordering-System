class FoodStore < ApplicationRecord

  has_many :chefs
  has_many :foods
  has_many :food_galleries
  has_many :carts
  
  validates :name, presence: true, null: false, uniqueness: { case_sensitive: false }

end
