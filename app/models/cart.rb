class Cart < ApplicationRecord
  belongs_to :user, optional: true
  has_many :cart_items, dependent: :destroy

  # daha sonra eklenebilir
  # enum status: { opem: "open, completed: "completed", cancelled: "cancelled" }

  def update_total_price!
    update(total_price: cart_items.sum("quantity * unit_price"))
  end
end
