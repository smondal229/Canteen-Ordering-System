module CartHelper

  def set_current_cart
    
    if !session[:cart_id].nil?
      @current_cart ||= Cart.find(session[:cart_id]) if !session[:cart_id].nil?
    else
      @current_cart = current_employee.carts.create
      session[:cart_id] = @current_cart.id
    end

    @current_cart
  end
  
end
