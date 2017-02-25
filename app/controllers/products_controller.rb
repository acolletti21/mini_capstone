
class ProductsController < ApplicationController
  before_action :authenticate_admin!, except: [:index, :show]

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
    authenticate_admin
    @product = Product.new
    #this @product is helping us use it in new.html erb to do our each loop
  end

  def create
    @product = Product.new(
                            name: params[:name],
                            price: params[:price],
                            supplier_id: params[:supplier][:supplier_id],
                            description: params[:description]
                            )
    if @product.save
      flash[:success] = "Product Successfully Created"
      redirect_to "/products/#{@product.id}"
    else
      render :new
    end
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
    @product.assign_attributes(
                            name: params[:name],
                            price: params[:price],
                            supplier_id: params[:supplier][:supplier_id],
                            description: params[:description]
                            )
    if @product.save
      flash[:success] = "Product Successfully Updated"
      redirect_to "/products/#{@product.id}"
    else
      render :edit
    end
  end

  def destroy
    @product = Product.find(params[:id])
    @product.destroy
    redirect_to "/products"
    flash[:warning] = "Product has been destroyed"
    redirect_to = "/products"
  end
     
end


