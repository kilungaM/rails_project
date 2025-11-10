class IngredientsController < ApplicationController
  def index
    @ingredients = Ingredient.includes(:meals).page(params[:page]).per(20)
  end

  def show
    @ingredient = Ingredient.find(params[:id])
    @meals = @ingredient.meals.includes(:category, :reviews).page(params[:page]).per(12)
  end
end