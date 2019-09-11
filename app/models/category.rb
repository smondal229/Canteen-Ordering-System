class Category < ApplicationRecord
  
  has_many :foods, dependent: :nullify

  validates :name, presence: true, uniqueness: { case_sensitive: false }, null: false
  before_save { self.name = self.name.to_s.titlecase}
end
