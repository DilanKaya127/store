class CartItem < ApplicationRecord
  belongs_to :cart
  belongs_to :product

  validates :quantity, presence: true, numericality: { greater_than: 0 }

  before_save :calculate_total_price
  after_save :update_cart_total_price
  after_destroy :update_cart_total_price

  private

  def calculate_total_price
    self.total_price = unit_price * quantity
  end

  def update_cart_total_price
    cart.update_total_price!
  end
end
