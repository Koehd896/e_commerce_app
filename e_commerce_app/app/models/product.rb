class Product < ActiveRecord::Base
  belongs_to :user
  has_many :product_carts
  has_many :carts, through: :product_carts

  validates :name, :price, :description, presence: true

end