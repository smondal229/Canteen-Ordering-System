class Food < ApplicationRecord
  
  belongs_to :food_store
  belongs_to :category
  
  has_one :cart_item, dependent: :destroy

  validates :name, :price, presence: true, null: false
  validates :name,  uniqueness: { case_sensitive: false, scope: :food_store_id }
  validates :price, null: false, numericality: { greater_than: 40, less_than: 1000}
  
  before_save { self.name = self.name.to_s.titlecase}

  scope :search_by_category_and_foodstore, ->(category, foodstore) { where(category: category, food_store: foodstore) }
  scope :search_by_category, ->(category) { where(category: category) }
  scope :search_by_foodstore, ->(foodstore) { where(food_store: foodstore) }
  scope :order_by_added, -> { order(:created_at) }
  
end
