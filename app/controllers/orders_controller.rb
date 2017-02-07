class OrdersController < ApplicationController
  def new
  end

  def create
    carted_products = CartedProduct.where(user_id: current_user.id, status: "carted")
    subtotal = 0

    carted_products.each do |carted_product|
      subtotal += (carted_product.product.price * carted_product.quantity)
    end

    order = Order.new(
                      user_id: session[:user_id],
                      subtotal: subtotal
                      )
    # order.calculate_subtotal
    order.calculate_tax
    order.calculate_total

    order.save
    redirect_to "/orders/#{order.id}"

    carted_products.each do |carted_product|
      carted_product.order_id = order.id
      carted_product.status = "purchased"
      carted_product.save
    end

  end

  def show
    @order = Order.find(params["id"])
  end
end
