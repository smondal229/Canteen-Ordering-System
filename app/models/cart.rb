class Cart < ApplicationRecord

  enum priority: [:Low, :High]

  belongs_to :employee
  belongs_to :food_store, optional: true
  belongs_to :status, optional: true
  
  has_many :cart_items, dependent: :destroy
  
  scope :find_by_employee, ->(employee) { where(employee: employee) }
  scope :find_by_foodstore, ->(foodstore) { where(food_store: foodstore) }
  scope :order_placed_desc, -> { where.not(placed_at: nil).order(placed_at: :desc) }
  scope :order_placed_priority_desc, -> { where.not(priority: nil).order(:priority, placed_at: :desc) }

  def checkout_cart
    update(placed_at: Time.now, total_price: self.total)
  end

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
