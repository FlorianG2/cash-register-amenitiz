class CartProduct < ApplicationRecord
  # validations
  validates :product_id, :quantity, :total, presence: true
  validates :product_id, uniqueness: { message: 'This product has already been added to the cart.' }
  validates :quantity, numericality: { only_integer: true }
end
