class User < ActiveRecord::Base
  has_one :cart
  has_many :products
  has_many :notifications
  has_secure_password

end