class User < ActiveRecord::Base
  has_one :cart
  has_many :products
  has_many :notifications
  has_secure_password

  validates :username, :email, :password, presence: true
  validates :username, :email, uniqueness: true

  after_initialize :set_balance

  def set_balance
    self.balance = 0
  end

end