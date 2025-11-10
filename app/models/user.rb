class User < ApplicationRecord
  # Associations
  has_many :reviews, dependent: :destroy
  has_many :meals, through: :reviews

  # Enable password handling
  has_secure_password

  # Validations
  validates :name, presence: true
  validates :email, presence: true, uniqueness: true
end
