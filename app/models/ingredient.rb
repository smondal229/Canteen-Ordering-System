class Ingredient < ApplicationRecord
  belongs_to :food

  has_one :cart_items#, dependent: :nullify

  validates_uniqueness_of :name, scope: :food_id

  before_save { self.name = self.name.to_s.titlecase}

end
