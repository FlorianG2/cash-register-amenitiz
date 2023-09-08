class CartProductsController < ApplicationController
  def index
    @cart_products = CartProduct.all
    @total = []
  end

  def new
    @id = params['format'].to_i
    @product = Product.find(@id)
    @cart_product = CartProduct.new(product_id: @id, quantity: 0, total: 0)
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

  def create
    values = params['cart_product'].values
    @product = Product.find(values[0])
    case @product.product_code
    when 'GR1'
      total = free_green_tea(@product.price, values[1].to_i)
      @cart_product = CartProduct.new(product_id: @product.id, quantity: values[1].to_i, total: total)
    when 'SR1'
      total = reduced_price_strawberries(@product.price, values[1].to_i)
      @cart_product = CartProduct.new(product_id: @product.id, quantity: values[1].to_i, total: total)
    when 'CF1'
      total = drop_price_coffee(@product.price, values[1].to_i)
      @cart_product = CartProduct.new(product_id: @product.id, quantity: values[1].to_i, total: total)
    end
    if @cart_product.save
      redirect_to cart_products_path
    else
      render :new, status: :unprocessable_entity
    end
  end

  def cart_product_params
    params.require(:cart_product).permit(:quantity, :total, :product_id)
  end

  def free_green_tea(price, quantity)
    if quantity > 2
      quantity_rounded = quantity / 2.0
      price * quantity_rounded.round
    elsif quantity == 1 || quantity == 2
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
