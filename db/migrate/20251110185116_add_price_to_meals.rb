class AddPriceToMeals < ActiveRecord::Migration[7.1]
  def change
    add_column :meals, :price, :decimal, precision: 8, scale: 2, default: 0.0, null: false
  end
end
