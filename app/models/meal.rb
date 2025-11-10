class Meal < ApplicationRecord
  # Associations
  belongs_to :category
  has_many :meal_ingredients, dependent: :destroy
  has_many :ingredients, through: :meal_ingredients
  has_many :reviews, dependent: :destroy
  has_many :users, through: :reviews

  # Validations
  validates :name, presence: true
  validates :api_id, uniqueness: true, allow_nil: true
  validates :price, presence: true, numericality: { greater_than_or_equal_to: 0 }

  # Instance Methods

  # Returns average rating rounded to 1 decimal, or 0 if no reviews
  def average_rating
    return 0.0 if reviews.empty?
    reviews.average(:rating).to_f.round(1)
  end

  # Returns the number of reviews
  def review_count
    reviews.count
  end
end
