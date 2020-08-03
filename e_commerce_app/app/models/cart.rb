class Cart < ActiveRecord::Base
  has_many :products, through: :product_carts
  belongs_to :user
end