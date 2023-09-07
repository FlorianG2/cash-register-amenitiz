class Cart < ApplicationRecord
  has_many :cart_product

  # validations
  validates :cart_product_id, :total, presence: true
end
