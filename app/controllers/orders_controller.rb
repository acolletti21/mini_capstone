class OrdersController < ApplicationController
  before_action :authenticate_user!
  #so user cant make orders without logging in

  def new
  end

  def create
    carted_products = current_user.cart
    # carted_products = CartedProduct.where(user_id: current_user.id, status: "carted")
    #this is fine too, just not as clean
    order = Order.create(user_id: current_user.id)
    carted_products.update.all(status: 'purchased', order_id: order.id)
    order.calculate_totals

    redirect_to '/orders/#{order.id}'
  end

  def show
    @order = Order.find(params["id"])
  end
end
