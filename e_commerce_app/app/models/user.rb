class User < ActiveRecord::Base
  has_one :cart
  has_many :products
  has_many :notifications
  has_secure_password

  validates :username, :email, presence: true
  validates :username, :email, uniqueness: true

  after_initialize :set_balance_and_cart

  def set_balance_and_cart
    self.balance ||= 0
    Cart.create(user_id: self.id)
    self.save
  end

end