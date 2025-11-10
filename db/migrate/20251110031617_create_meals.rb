class CreateMeals < ActiveRecord::Migration[7.1]
  def change
    create_table :meals do |t|
      t.string :name
      t.references :category, null: false, foreign_key: true
      t.string :area
      t.text :instructions
      t.string :thumb_url
      t.string :video_url
      t.string :api_id

      t.timestamps
    end
  end
end
