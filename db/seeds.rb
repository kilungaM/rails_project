# ------------------------------
# Meals
# ------------------------------
10.times do
  meal_name = Faker::Food.dish
  Meal.find_or_initialize_by(name: meal_name).tap do |meal|
    meal.category = Category.order("RANDOM()").first
    meal.price = rand(5..25)
    # Add random coordinates for mapping (example around Toronto)
    meal.latitude = 43.6532 + rand(-0.05..0.05)
    meal.longitude = -79.3832 + rand(-0.05..0.05)
    meal.save!(validate: false)
  end
end
puts "Created #{Meal.count} meals!"
