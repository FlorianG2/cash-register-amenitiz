class ProductsController < ApplicationController
  def index
    @products = Product.all
    @cart_products = []
  end
end
