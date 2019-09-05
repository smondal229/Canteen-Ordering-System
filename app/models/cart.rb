class Cart < ApplicationRecord

  enum priority: [:Low, :High]

  belongs_to :employee
  belongs_to :food_store, optional: true
  belongs_to :status, optional: true
  
  has_many :cart_items, dependent: :destroy
  
  def total
    @total = 0
    self.cart_items.each do |item|
      @total += item.quantity * item.food.price
    end
    @total
  end

  def delivered
    update(delivered_at: Time.now)
  end

end
