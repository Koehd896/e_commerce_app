class User < ActiveRecord::Base
  has_one :cart
  has_many :products
end