class CartsController < ApplicationController
  def show
    @products = Product.all
  end

  def free_green_tea(cart_product)
    if cart_product.quantity > 2
      quantity = cart_product.quantity / 2.0
      cart_product.total * quantity.round
    elsif cart_product.quantity == 1 || cart_product.quantity == 2
      cart_product.total
    else
      0
    end
  end

  def reduced_price_strawberries(cart_product)
    quantity = cart_product.quantity
    if quantity > 2
      discount = 0.9
      (cart_product.total * discount) * quantity
    else
      cart_product.total * quantity
    end
  end

  def drop_price_coffee(cart_product)
    quantity = cart_product.quantity
    if quantity > 2
      discount = 2.0 / 3
      (cart_product.total * discount) * quantity
    else
      cart_product.total * quantity
    end
  end
end
