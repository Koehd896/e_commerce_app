class Product < ActiveRecord::Base
  belongs_to :user
  has_many :carts, through: :product_carts
end