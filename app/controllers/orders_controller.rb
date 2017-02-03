class OrdersController < ApplicationController
  def new
  end

  def create

    order = Order.new(
                      quantity: params[:quantity],
                      user_id: session[:user_id],
                      product_id: params[:product_id]
                      )
    order.calculate_subtotal
    order.calculate_tax
    order.calculate_total

    order.save
    redirect_to "/orders/#{order.id}"
  end

  def show
    @order = Order.find(params["id"])
  end
end
