class ProductsController < ApplicationController
  def index
    @products = Product.all
    @cart_products = []
    @cart_product = CartProduct.new
  end
end
