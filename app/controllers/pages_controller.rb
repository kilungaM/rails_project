class PagesController < ApplicationController
  def home
    @featured_meals = Meal.includes(:category, :reviews).limit(6)
    @categories = Category.all
    @total_meals = Meal.count
    @total_reviews = Review.count
  end

  def about
    @categories = Category.count
    @meals = Meal.count
    @ingredients = Ingredient.count
    @users = User.count
    @reviews = Review.count
  end
end