class Product < ApplicationRecord
  
  belongs_to :supplier
  has_many :images
  has_many :carted_products
  has_many :orders, through: :carted_products

  has_many :product_categories
  has_many :categories, through: :product_categories

  validates :name, presence: true
  validates :price, presence: true
  validates :description, presence: true
  validates :description, length: {in: 200..500}

  def sale_message
    if price.to_i < 200
      sale_message = "Discount Item!"
    else 
      sale_message = "Everyday Value!"
    end
  end

  def discounted?
    price.to_i < 200
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

end