class Category < ApplicationRecord
  
  has_many :foods, dependent: :nullify

  validates :name, null: false, presence: true, uniqueness: { case_sensitive: false }
  before_save { self.name = self.name.to_s.titlecase}

  scope :order_by_name, -> { order("name") }
end
