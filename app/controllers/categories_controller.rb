class CategoriesController < ApplicationController
  skip_before_action :set_notification_badge, only: [:new, :create, :edit, :update, :destroy]
  before_action :authenticate_admin, only: [:new, :create, :edit, :update, :destroy]
  before_action :set_category, only: [:edit, :update, :destroy, :show]
  
  def index
    @categories = Category.all.paginate(page: params[:page])
  end
  
  def new
    @category = Category.new
  end

  def create
    @category = Category.new(category_params)

    if @category.save
      redirect_to(categories_path, flash: { success: "New category added" })
    else
      render "new"
    end

  end

  def edit
  end

  def update
    if @category.update(category_params)
      redirect_to(categories_path, flash: { success: "Category updated" })
    else
      render "edit"
    end
  end

  def show
    redirect_to(foods_path(category: @category))
  end
  
  def destroy
    @category.destroy
    redirect_to(categories_path, flash: { info: "Category deleted" })
  end

  private
    def category_params
      params.require(:category).permit(:name)
    end

    def set_category
      @category = Category.find(params[:id])
    end
  
end
