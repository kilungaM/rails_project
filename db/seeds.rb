require 'net/http'
require 'json'

puts "Fetching meals from TheMealDB API..."

# Coordinates for each area/country (simplified for mapping)
area_coords = {
  "American" => [37.0902, -95.7129],
  "British" => [55.3781, -3.4360],
  "Canadian" => [56.1304, -106.3468],
  "Chinese" => [35.8617, 104.1954],
  "Croatian" => [45.1, 15.2],
  "Dutch" => [52.1326, 5.2913],
  "Egyptian" => [26.8206, 30.8025],
  "Filipino" => [12.8797, 121.7740],
  "French" => [46.2276, 2.2137],
  "Greek" => [39.0742, 21.8243],
  "Indian" => [20.5937, 78.9629],
  "Irish" => [53.4129, -8.2439],
  "Italian" => [41.8719, 12.5674],
  "Jamaican" => [18.1096, -77.2975],
  "Japanese" => [36.2048, 138.2529],
  "Kenyan" => [-0.0236, 37.9062],
  "Malaysian" => [4.2105, 101.9758],
  "Mexican" => [23.6345, -102.5528],
  "Moroccan" => [31.7917, -7.0926],
  "Polish" => [51.9194, 19.1451],
  "Portuguese" => [39.3999, -8.2245],
  "Russian" => [61.5240, 105.3188],
  "Spanish" => [40.4637, -3.7492],
  "Thai" => [15.87, 100.9925],
  "Tunisian" => [33.8869, 9.5375],
  "Turkish" => [38.9637, 35.2433],
  "Ukrainian" => [48.3794, 31.1656],
  "Vietnamese" => [14.0583, 108.2772]
}

# Fetch meals from different categories
categories = ['Seafood', 'Chicken', 'Beef', 'Pasta', 'Vegetarian', 'Dessert']

categories.each do |cat_name|
  # Find or create category
  category = Category.find_or_create_by(name: cat_name)

  # Fetch meals for this category from API
  url = "https://www.themealdb.com/api/json/v1/1/filter.php?c=#{cat_name}"
  uri = URI(url)
  response = Net::HTTP.get(uri)
  data = JSON.parse(response)

  data['meals']&.first(5)&.each do |meal_summary|
    # Fetch full meal details
    detail_url = "https://www.themealdb.com/api/json/v1/1/lookup.php?i=#{meal_summary['idMeal']}"
    detail_uri = URI(detail_url)
    detail_response = Net::HTTP.get(detail_uri)
    meal_data = JSON.parse(detail_response)['meals']&.first
    next unless meal_data

    # Assign coordinates if area exists
    coords = area_coords[meal_data['strArea']] || [0, 0]

    Meal.find_or_initialize_by(api_id: meal_data['idMeal']).tap do |meal|
      meal.name = meal_data['strMeal']
      meal.category = category
      meal.area = meal_data['strArea']
      meal.instructions = meal_data['strInstructions']
      meal.thumb_url = meal_data['strMealThumb']
      meal.video_url = meal_data['strYoutube']
      meal.price = rand(5..25)
      meal.latitude = coords[0]
      meal.longitude = coords[1]
      meal.save!(validate: false)
    end

    puts "  Created: #{meal_data['strMeal']} (#{meal_data['strArea']})"
  end
end

puts "Created #{Meal.count} meals from TheMealDB API!"
