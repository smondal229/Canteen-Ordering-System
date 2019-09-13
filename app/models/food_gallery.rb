class FoodGallery < ApplicationRecord
  belongs_to :food_store

  has_attached_file :image, styles: { medium: "400x400>", thumb: "200x200>" }
  validates_attachment_content_type :image, content_type: /\Aimage\/.*\z/
  validates_attachment_presence :image

  scope :find_by_foodstore, ->(foodstore) { where(food_store: foodstore) }
  scope :order_by_desc, -> { order(created_at: :desc) }

end
