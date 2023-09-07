require 'rails_helper'

RSpec.describe Cart, type: :model do
  describe 'Validation' do
    it 'is not valid without a cart_product_id' do
      cart = Cart.new(cart_product_id: nil, total: 3.11)
      expect(cart).to_not be_valid
    end

    it 'is not valid without a total' do
      product = Product.create!(product_code: 'GR1', name: 'Green Tea', price: 3.11)
      cart_product = CartProduct.new(product_id: product.id, quantity: nil, total: 3.11)
      cart = Cart.new(cart_product_id: cart_product.id, total: nil)
      expect(cart).to_not be_valid
    end

    it 'is valid with product_id, quantity and total' do
      product = Product.create!(product_code: 'GR1', name: 'Green Tea', price: 3.11)
      cart_product = CartProduct.create!(product_id: product.id, quantity: 1, total: 3.11)
      cart = Cart.new(cart_product_id: cart_product.id, total: 3.11)
      expect(cart).to be_valid
    end
  end
end
