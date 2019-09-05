class CartItemsController < ApplicationController
  before_action :authenticate_employee
  before_action{ approved(current_employee) }
  before_action :set_current_cart
  before_action :set_cart_item, only: [:edit, :update, :destroy]

  def new
    @cart_item = @current_cart.cart_items.new(food_id: params[:food])
  end

  def create
    @food_store = Food.find(params[:cart_item][:food_id]).food_store
    @current_cart.update(food_store: @food_store) if @current_cart.food_store.nil?

    if @current_cart.food_store == @food_store
      @cart_item = @current_cart.cart_items.new(cart_item_params)

      if @cart_item.save
        redirect_to(cart_path(@current_cart), flash: { success: "Food added to cart" } )
      else
        render "new"
      end

    else
      redirect_to(cart_path(@current_cart), flash: { danger: "You can only add food from one food store otherwise delete all foods first" } )  
    end
  end


  def edit
  end

  def update
    if @cart_item.update(cart_item_params)
      redirect_to(cart_path(@current_cart), flash: { success: "Food added to cart!" })
    else
      redirect_back(fallback_location: root_path, flash: { danger: "Food was not added!" })
    end
  end


  def destroy
    @cart_item.destroy

    if @current_cart.cart_items.count == 0
      @current_cart.update(food_store: nil)
    end

    redirect_back(fallback_location: root_path, flash: { info:  "Food Removed from cart" } )
  end

  private
    def cart_item_params
      params.require(:cart_item).permit(:food_id, :quantity, :description)
    end

    def set_cart_item
      @cart_item = CartItem.find(params[:id])
    end
end
