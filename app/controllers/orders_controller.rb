class OrdersController < ApplicationController
  def new
  end

  def create

    order = Order.new(
                      quantity: params[:quantity],
                      user_id: session[:user_id],
                      product_id: params[:product_id],
                      subtotal: calculated_subtotal,
                      tax: calculated_tax,
                      total: calculated_total,
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

  # def current_product
  #   @current_product == Product
  # end
  # helper_method :current_user
end
