class FoodStoresController < ApplicationController
  before_action :authenticate_admin, only: [:new, :create, :edit, :update, :destroy]
  before_action :set_foodstore, only: [:edit, :update, :destroy, :show, :menu]
  
  def index
    @food_stores = FoodStore.all.paginate(page: params[:page])
  end
  
  def new
    @food_store = FoodStore.new
  end

  def create
    @food_store = FoodStore.new(food_store_params)
    
    if @food_store.save
      redirect_to(food_stores_path, flash: { success: "Food Store added" })
    else
      render "new"
    end

  end

  def edit
  end

  def update
    if @food_store.update(food_store_params)
      redirect_to(food_stores_path, flash: {success: "Food Store data updated"})
    else
      render "edit"
    end
  end

  def show
    @food_galleries = FoodGallery.includes(:food_store).where(food_store_id: params[:id]).paginate(page: params[:page], per_page: 7)
  end
  
  def menu
    @foods = Food.includes(:food_store).where(food_store_id: params[:id])
  end

  def destroy
    @food_store.destroy
    redirect_to(food_stores_path, flash: { info: "#{@food_store.name} deleted" })
  end

  private
    def food_store_params
      params.require(:food_store).permit(:name, category_ids:[])
    end

    def set_foodstore
      @food_store = FoodStore.find(params[:id])
    end
  
end
