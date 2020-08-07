class Cart < ActiveRecord::Base
  has_many :product_carts
  has_many :products, through: :product_carts
  belongs_to :user

  validates :user_id, uniqueness: true

end