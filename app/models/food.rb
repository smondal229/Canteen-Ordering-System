class Food < ApplicationRecord
  
  belongs_to :food_store
  belongs_to :category
  
  has_one :cart_item, dependent: :destroy

  validates :name, :price, presence: true, null: false
  validates_uniqueness_of :name, scope: :food_store_id
  validates :price, null: false, numericality: { greater_than: 40, less_than: 1000}
  
  before_save { self.name = self.name.to_s.titlecase}


end
