class Product < ApplicationRecord
  
  belongs_to :supplier
  has_many :images
  has_many :orders
  has_many :product_categories
  has_many :categories, through: :product_categories


  def sale_message
    if price.to_i < 200
      sale_message = "Discount Item!"
    else 
      sale_message = "Everyday Value!"
    end
  end

  def discounted?
    if price.to_i < 200
  end

  def tax 
    price * 0.09
  end

  def total 
    price + tax
  end

  def default_image
    if images.count > 0
      images.first.url
    else
      "http://glamorousheels.com/wp-content/uploads/2015/01/christian-louboutin-high-heels.jpg"
    end
  end

end #why this extra end tag?
end