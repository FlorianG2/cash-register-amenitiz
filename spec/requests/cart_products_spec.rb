require 'rails_helper'

RSpec.describe "CartProducts", type: :request do
  describe 'Discounts' do
    context 'Green Tea' do
      it 'When buy one green tea get one for free' do
        green_tea = Product.create!(product_code: 'GR1', name: 'Green Tea', price: 3.11)
        cart_green_tea = CartProduct.new(product_id: green_tea.id, quantity: 2, total: 3.11)
        actual = CartProductsController.new.free_green_tea(green_tea.price, cart_green_tea.quantity)
        expected = cart_green_tea.total
        expect(actual).to eq(expected)
      end

      it 'If buy 5 green teas, get the price of 3' do
        green_tea = Product.create!(product_code: 'GR1', name: 'Green Tea', price: 3.11)
        cart_green_tea = CartProduct.create!(product_id: green_tea.id, quantity: 5, total: green_tea.price)
        actual = CartProductsController.new.free_green_tea(green_tea.price, cart_green_tea.quantity)
        expected = green_tea.price * (cart_green_tea.quantity / 2.0).round
        expect(actual).to eq(expected)
      end
    end

    context 'Strawberries' do
      it 'When buy 3 or more the price change into 4.50€' do
        strawberries = Product.create!(product_code: 'SR1', name: 'Strawberries', price: 5.00)
        cart_strawberries = CartProduct.create!(product_id: strawberries.id, quantity: 5, total: strawberries.price)
        discount = 0.9
        actual = CartProductsController.new.reduced_price_strawberries(strawberries.price, cart_strawberries.quantity)
        expected = (strawberries.price * discount) * cart_strawberries.quantity
        expect(actual).to eq(expected)
      end

      it 'When buy 2, the price should be 10€' do
        strawberries = Product.create!(product_code: 'SR1', name: 'Strawberries', price: 5.00)
        cart_strawberries = CartProduct.create!(product_id: strawberries.id, quantity: 2, total: strawberries.price)
        actual = CartProductsController.new.reduced_price_strawberries(strawberries.price, cart_strawberries.quantity)
        expected = strawberries.price * cart_strawberries.quantity
        expect(actual).to eq(expected)
      end
    end

    context 'Coffee' do
      it 'when buy 2, the price should be 22.46€' do
        coffee = Product.create!(product_code: 'CF1', name: 'Coffee', price: 11.23)
        cart_coffee = CartProduct.create!(product_id: coffee.id, quantity: 2, total: coffee.price)
        actual = CartProductsController.new.drop_price_coffee(coffee.price, cart_coffee.quantity)
        expected = coffee.price * cart_coffee.quantity
        expect(actual).to eq(expected)
      end

      it 'when buy 3 or more the price of all coffees drop to 2/3 of the original price' do
        coffee = Product.create!(product_code: 'CF1', name: 'Coffee', price: 11.23)
        cart_coffee = CartProduct.create!(product_id: coffee.id, quantity: 5, total: coffee.price)
        discount = 2 / 3.0
        actual = CartProductsController.new.drop_price_coffee(coffee.price, cart_coffee.quantity)
        expected = (coffee.price * discount) * cart_coffee.quantity
        expect(actual).to eq(expected)
      end
    end
  end
end
