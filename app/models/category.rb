class Category < ApplicationRecord
  has_many :meals, dependent: :destroy
end
