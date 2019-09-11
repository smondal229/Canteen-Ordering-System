class Company < ApplicationRecord
  
  has_many :employees, dependent: :nullify
  
  validates :name, presence: true, null: false, uniqueness: { case_sensitive: false }
  before_save { self.name = self.name.to_s.titlecase}

end
