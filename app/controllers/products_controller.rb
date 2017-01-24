
class ProductsController < ApplicationController
  def index
    @products = Product.all
  end


  def new
  end

  def create
    @products = Products.new(
                            name: params[:name],
                            price: params[:price],
                            image: params[:image],
                            description: params[:description]
                            )
    @product.save
    flash[:success] = "Product Successfully Created"
    redirect_to "/products/#{@product.id}"
  end

  def show
    @product = Product.find(params[:id])
  end

  def edit
    @product = Product.find(params[:id])
  end

  def update
    @product = Product.find(params[:id])
    @product.name = params[:name]
    @product.price = params[:price]
    @product.image = params[:image]
    @product.description = params[:description]

    @product.save
    flash[:success] = "Product Successfully Updated"
    redirect_to "/products/#{@product.id}"
  end

  def destroy
    @product = Product.find(params[:id])
    @product.destroy
    redirect_to "/products"
    flash[:warning] = "Product has been destroyed"
    redirect_to = "/products"
  end
    

end


