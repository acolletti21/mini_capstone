class ProductsController < ApplicationController
  def all_products
    @products = Product.all
  end
end
