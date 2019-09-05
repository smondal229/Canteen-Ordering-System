class HomeController < ApplicationController
  before_action :logged_in?, only:[:signup, :create]

  def index
    @categories = Category.order(:name).limit(10)
    @food_stores = FoodStore.order(:name).limit(10)
  end

  def signup
  end

  def create

    if params[:user][:type].present?
      user_class = params[:user][:type]

      if user_class == "Employee"
        user = Employee.new(signup_params)

        if user.save
          session[user_class.downcase.concat("_id").to_sym] = user.id
          redirect_to( employee_path(user.id), flash: {success: "Sign Up successfully"})
        else
          @errors = user.errors.full_messages
          render "signup"
        end
      else
        user = Chef.create(signup_params)
        
        if user.save
          session[user_class.downcase.concat("_id").to_sym] = user.id
          redirect_to( chef_path(user.id), flash: {success: "Sign Up successfully"})
        else
          @errors = user.errors.full_messages
          render "signup"
        end
      end
    else
      flash[:info] = "Please select an option"
      render "new"
    end

  end

  private
    def signup_params
      params.require(:user).permit(:email, :password, :password_confirmation)
    end
end
