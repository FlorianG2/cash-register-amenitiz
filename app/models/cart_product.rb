class CartProduct < ApplicationRecord
  # validations
  validates :product_id, :quantity, :total, presence: true
  validates :product_id, uniqueness: true
  validates :quantity, numericality: { only_integer: true }
end
