class Cart < ApplicationRecord

  enum priority: [:Low, :High]

  belongs_to :employee
  belongs_to :food_store, optional: true
  belongs_to :status, optional: true
  
  has_many :cart_items, dependent: :destroy
  
  scope :fetch_history,     -> { includes(:employee, :food_store, {cart_items: :food}, :status) }
  scope :fetch_pending,     -> { includes({employee: :company}, :food_store, :status) }
  scope :fetch_recieved,    -> { includes({ employee: :company }, :food_store, { cart_items: :food }, :status) }
  scope :order_placed_desc, -> { where.not(placed_at: nil).order("placed_at DESC") }
  scope :order_placed_priority_desc, ->{ where.not(priority: nil).order("placed_at, priority DESC") }

  
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
