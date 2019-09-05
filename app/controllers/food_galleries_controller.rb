class FoodGalleriesController < ApplicationController

  before_action :set_food_store
  before_action :authenticate_chef, only: [:new, :create]
  before_action ->{ approved(current_chef) }, only: [:new, :create]
  
  def new
    @food_gallery = @food_store.food_galleries.build
  end

  def create
    @food_gallery = @food_store.food_galleries.build(image_params)
    
    if @food_gallery.save 
      redirect_to(food_store_path(@food_store), flash: { success: "Image has been uploaded successfully" })
    else
      render "new"
    end
  end

  private
    def image_params
      params.require(:food_gallery).permit(:description, :image)
    end

    def set_food_store
      @food_store = FoodStore.find(params[:food_store_id])
    end
end
