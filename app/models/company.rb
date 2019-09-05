class Company < ApplicationRecord
  
  has_many :employees
  validates :name, presence: true, null: false
  before_save { self.name = self.name.to_s.titlecase}

end
