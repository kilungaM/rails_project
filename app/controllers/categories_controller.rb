class CategoriesController < ApplicationController
  def index
    @categories = Category.all
  end

  def show
    @category = Category.find(params[:id])
    @meals = @category.meals.includes(:reviews).page(params[:page]).per(12)
  end
end