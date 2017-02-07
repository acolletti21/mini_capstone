class CartedProductsController < ApplicationController
  
  def index
    @carted_products = current_user.carted_products.where(status: "carted")
    # @carted_products = CartedProduct.where(user_id: current_user.id, status: "carted")
    #this way above its fine too but this is preferred
    if @carted_products.count == 0
      redirect_to '/products'
    end
  end

  def create
    carted_product = CartedProduct.new(
                      user_id: current_user.id,
                      product_id: params[:product_id],
                      quantity: params[:quantity],
                      status: "carted"
                      )
    carted_product.save
    redirect_to "/carted_products"
  end


  def destroy
    carted_product = CartedProduct.find(params[:id]) 
    carted_product.status = "removed"
    redirect_to '/carted_products'
    carted_product.save
  end
end
