require 'rails_helper'

RSpec.describe CartProduct, type: :model do
  describe 'Validation' do
    it 'is not valid without a product_id' do
      cart_product = CartProduct.new(product_id: nil, quantity: 1, total: 3.11)
      expect(cart_product).to_not be_valid
    end

    it 'is not valid without a quantity' do
      product = Product.create!(product_code: 'GR1', name: 'Green Tea', price: 3.11)
      cart_product = CartProduct.new(product_id: product.id, quantity: nil, total: 3.11)
      expect(cart_product).to_not be_valid
    end

    it 'is not valid with a quantity not integer' do
      product = Product.create!(product_code: 'GR1', name: 'Green Tea', price: 3.11)
      cart_product = CartProduct.new(product_id: product.id, quantity: 'One', total: 3.11)
      expect(cart_product).to_not be_valid
    end

    it 'is not valid without a total' do
      product = Product.create!(product_code: 'GR1', name: 'Green Tea', price: 3.11)
      cart_product = CartProduct.new(product_id: product.id, quantity: 1, total: nil)
      expect(cart_product).to_not be_valid
    end

    it 'is valid with product_id, quantity and total' do
      product = Product.create!(product_code: 'GR1', name: 'Green Tea', price: 3.11)
      cart_product = CartProduct.new(product_id: product.id, quantity: 1, total: 3.11)
      expect(cart_product).to be_valid
    end
  end
end
