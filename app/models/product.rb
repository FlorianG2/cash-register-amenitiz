class Product < ApplicationRecord
  # validations
  validates :product_code, :name, :price, presence: true
end
