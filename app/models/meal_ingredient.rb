class MealIngredient < ApplicationRecord
  belongs_to :meal
  belongs_to :ingredient

  validates :meal_id, uniqueness: { scope: :ingredient_id }
end
