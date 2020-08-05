class User < ActiveRecord::Base
  has_one :cart
  has_many :products
  has_many :notifications
  has_secure_password

  after_initialize :set_balance

  def set_balance
    self.balance = 0
  end

end