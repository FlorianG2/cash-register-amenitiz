class CartsController < ApplicationController
  def show
    @products = Product.all
    @cart_products = []
  end
end
