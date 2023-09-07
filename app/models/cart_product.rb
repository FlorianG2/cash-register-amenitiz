class CartProduct < ApplicationRecord
  # validations
  validates :product_id, :quantity, :total, presence: true
end
