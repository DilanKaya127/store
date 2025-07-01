class User < ApplicationRecord
  has_secure_password
  has_many :sessions, dependent: :destroy

  belongs_to :supplier, foreign_key: "supplier_id", primary_key: "id", optional: true

  normalizes :email_address, with: ->(e) { e.strip.downcase }

  # rol validations
  validates :role, inclusion: { in: %w[user admin] }

  def admin?
    role == "admin"
  end

  def user?
    role == "user"
  end

  # admin kullanıcının supplier'ına ait ürünleri yönetebilir
  def can_manage_products?
    admin? && supplier.present?
  end
end
