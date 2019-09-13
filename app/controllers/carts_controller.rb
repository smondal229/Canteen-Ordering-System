class CartsController < ApplicationController

  before_action :authenticate_employee, only: [:show, :destroy, :checkout, :history]
  before_action(only: [:show, :destroy, :checkout, :history]){ approved(current_employee) }
  before_action :set_current_cart, only: [:show, :destroy, :checkout]
  before_action :authenticate_admin, only: [:pending]
  before_action :authenticate_chef, only: [:recieved]
  before_action :set_cart, only: [:edit, :update]

  def edit
  end

  def update
    if @cart.update(cart_params)

      if current_admin
        redirect_to(pending_carts_path, flash: { success: "Order has been updated" })
      elsif current_chef

        if @cart.status.name == "Delivered"
          @cart.delivered
        end

        if @cart.employee.order_notification_visible
          Notification.create(notifiable: @cart.employee, content: "Your order is #{ @cart.status.name }")
        end

        if current_chef.order_notification_visible
          Notification.create(notifiable: current_chef, content: "Order id #{@cart.id} is #{ @cart.status.name }")
        end

        redirect_to(recieved_carts_path, flash: { success: "Update done" })
      end
    else
      redirect_back(fallback_location: root_path, flash: { danger: "Update cannot be done" })
    end
  end

  def show
  end

  def destroy
    session[:cart_id] = nil
    @current_cart.destroy
    redirect_back(fallback_location: root_path, flash: { info: "All foods deleted" } )
  end

  def checkout
    @current_cart.checkout_cart
    session[:cart_id] = nil
    redirect_to(history_carts_path, flash: { success: "Your order has been placed " })
  end

  def history
    @orders = Cart.includes(:employee, :food_store, { cart_items: :food }, :status).find_by_employee(current_employee).order_placed_desc
  end

  def pending
    @orders = Cart.includes({ employee: :company }, :food_store, :status).order_placed_desc
  end

  def recieved
    @orders = Cart.includes({ employee: :company }, :food_store, { cart_items: :food }, :status).find_by_foodstore(current_chef.food_store).order_placed_priority_desc
  end

  private
    def set_cart
      @cart = Cart.find(params[:id])
    end

    def cart_params
      params.require(:cart).permit(:status_id, :priority)
    end
end
