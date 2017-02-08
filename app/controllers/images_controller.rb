class ImagesController < ApplicationController
  before_action :authenticate_admin!
  
  def new
    @product = Product.find(params[:product_id])
  end

  def create
    Image.create(url: params[:url], product_id: params[:product_id])
    redirect_to "/products/#{params[:product_id]}"
  end
end
