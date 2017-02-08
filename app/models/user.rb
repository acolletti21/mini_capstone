class User < ApplicationRecord
  has_secure_password
  has_many :orders
  has_many :carted_products

  validates :email, presence: true
  validates :email, uniqueness: true
  validates :email, format: {with: /\w{2,}\@\w+\.\w{2,3}/, message: "please enter a valid email"  }
  validates :name, presence: true
  validates :name, length: { minimum: 2} 

  def cart
    carted_products.where(status: 'carted')
  end

end
