
class ProductsController < ApplicationController
  def index
    @products = Product.all
    sort_attribute = params[:sort]
    sort_order = params[:sort_order]
    discount_amount = params[:discount]
    search_term = params[:search_term]
    category_type = params[:category]

    if search_term
      @products = @products.where("name iLIKE ? OR description iLIKE ?",
                            "%#{search_term}%",
                            "%#{search_term}%")
    end

    if category_type
      category = Category.find_by(name: category_type)
      @products = category.products
    end 

    if sort_attribute && sort_order
      @products = @products.order(sort_attribute => sort_order)
    elsif sort_attribute
      @products = @products.order(sort_attribute)
    end  

    if discount_amount
      @products = @products.where("price < ?", 200)
    end
  end


  def new
  end

  def create
    @product = Product.new(
                            name: params[:name],
                            price: params[:price],
                            supplier_id: params[:supplier][:supplier_id],
                            description: params[:description]
                            )
    @product.save
    flash[:success] = "Product Successfully Created"
    redirect_to "/products/#{@product.id}"
  end

  def show
    if params[:id] == "random"
      product = Product.all.sample
      redirect_to "/products/#{product.id}"
    else 
      @product = Product.find(params[:id])
    end
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


