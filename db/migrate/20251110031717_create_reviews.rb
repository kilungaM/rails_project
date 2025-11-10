class CreateReviews < ActiveRecord::Migration[7.1]
  def change
    create_table :reviews do |t|
      t.references :user, null: false, foreign_key: true
      t.references :meal, null: false, foreign_key: true
      t.integer :rating
      t.text :comment
      t.integer :helpful_count

      t.timestamps
    end
  end
end
