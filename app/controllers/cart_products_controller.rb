class CartProductsController < ApplicationController
  def index
    @cart_products = CartProduct.all
    @total = []
  end

  def create
    values = params['cart_product'].values
    @product = Product.find(values[0])
    total = total(@product, values[1].to_i)
    @cart_product = CartProduct.new(product_id: @product.id, quantity: values[1].to_i, total: total)
    @cart_product.save
    redirect_to cart_products_path
  end

  def edit
    @cart_product = CartProduct.find(params[:id])
  end

  def update
    values = params['cart_product'].values
    @product = Product.find(values[0])
    @cart_product = CartProduct.find(params[:id])
    if params[:cart_product][:quantity].to_i <= 0
      @cart_product.destroy
    else
      total = total(@product, params[:cart_product][:quantity].to_i)
      @cart_product.update(quantity: params[:cart_product][:quantity].to_i, total: total)
      @cart_product.save
    end
    redirect_to cart_products_path
  end

  def destroy_all
    CartProduct.destroy_all
    redirect_to cart_products_path, status: :see_other
  end

  def destroy
    @cart_product = CartProduct.find(params[:id])
    @cart_product.destroy
    redirect_to cart_products_path, status: :see_other
  end

  def total(product, quantity)
    case product.product_code
    when 'GR1'
      free_green_tea(product.price, quantity)
    when 'SR1'
      reduced_price_strawberries(product.price, quantity)
    when 'CF1'
      drop_price_coffee(product.price, quantity)
    end
  end

  def free_green_tea(price, quantity)
    if quantity > 2
      quantity_divided = quantity / 2.0
      price * quantity_divided.round
    elsif [1, 2].include?(quantity)
      price
    else
      0
    end
  end

  def reduced_price_strawberries(price, quantity)
    if quantity > 2
      discount = 0.9
      (price * discount) * quantity
    else
      price * quantity
    end
  end

  def drop_price_coffee(price, quantity)
    if quantity > 2
      discount = 2.0 / 3
      (price * discount) * quantity
    else
      price * quantity
    end
  end
end
