class Product < ApplicationRecord
  
  belongs_to :supplier

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

end #why this extra end tag?
end