class FoodsController < ApplicationController

  before_action :authenticate_chef, except: [:index]
  before_action :set_food, only: [:edit, :update, :show, :destroy]
  before_action :belongs_to_food_store?, only: [:edit, :update, :destroy]
  
  def index

    if params[:food_store].present? && params[:category].present?
      set_food_store
      @foods = Food.includes([:category, :food_store]).where(category: params[:category], food_store: params[:food_store])   
    elsif params[:category].present?
      @category = Category.find(params[:category])
      @foods = Food.includes(:category).where(category: params[:category])
    elsif params[:food_store].present?
      set_food_store
      @foods = Food.includes(:food_store).where(food_store: params[:food_store])
    else
      @foods = Food.order_by_name
    end

    @foods = @foods.paginate(page: params[:page])
  end

  def new
    set_food_store
    @food = @food_store.foods.new
  end

  def create
    @food = Food.new(food_params)
    
    if @food.save
      redirect_to(food_path(@food), flash: { success: "New Food Added" })
    else
      render "new"
    end
  end

  def edit
  end

  def update
    if @food.update(food_params)
      redirect_to(food_path(@food), flash: { success: "Food Updated" })
    else
      render "edit"
    end
  end

  def show
  end

  def destroy
    @food.destroy
    redirect_to(foods_path(food_store: current_chef.food_store), flash: { success: "#{@food.name} deleted" })
  end

  private
    def food_params
      params.require(:food).permit(:name, :price, :category_id, :food_store_id)
    end

    def set_food_store
      @food_store = FoodStore.find(params[:food_store])
    end

    def belongs_to_food_store?
      if (current_chef.food_store != @food.food_store || !current_chef.approved)
        redirect_back(fallback_location: root_path, flash: { danger: "You need to be chef of this food store!" })
      end
    end

    def set_food
      @food = Food.find(params[:id])
    end

end
