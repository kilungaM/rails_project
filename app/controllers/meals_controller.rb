class MealsController < ApplicationController
  def index
    @meals = Meal.includes(:category, :reviews).page(params[:page]).per(12)
  end

  def show
    @meal = Meal.includes(:category, :ingredients, :reviews => :user).find(params[:id])
  end

  def search
    @query = params[:query]
    @category_id = params[:category_id]

    @meals = Meal.includes(:category, :reviews)

    if @query.present?
      @meals = @meals.where("name LIKE ? OR area LIKE ? OR instructions LIKE ?",
                            "%#{@query}%", "%#{@query}%", "%#{@query}%")
    end

    if @category_id.present? && @category_id != ""
      @meals = @meals.where(category_id: @category_id)
    end

    @meals = @meals.page(params[:page]).per(12)
    @categories = Category.all
  end
end