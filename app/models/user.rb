class User < ApplicationRecord
  has_secure_password
  has_many :sessions, dependent: :destroy

  has_many :carts

  belongs_to :supplier, foreign_key: "supplier_id", primary_key: "id", optional: true
  belongs_to :customer, foreign_key: "customer_id", primary_key: "id"

  normalizes :email_address, with: ->(e) { e.strip.downcase }

  # rol validations
  validates :role, inclusion: { in: %w[user admin] }
  validates :email_address, presence: true, uniqueness: true, length: { maximum: 255 }
  validates :full_name, presence: true, length: { maximum: 255 }
  # validates :first_name, presence: true, length: { maximum: 255 }
  # validates :last_name, presence: true, length: { maximum: 255 }

  def admin?
    role == "admin"
  end

  def user?
    role == "user"
  end

  before_validation :set_default_role, on: :create
  before_validation :create_customer_or_supplier_if_needed, on: :create

  def set_default_role
    self.role ||= "user"
  end

  def create_customer_or_supplier_if_needed
    if self.role == "admin"
      if self.supplier_id.blank?
        supplier = Supplier.create!(company_name: self.full_name)
        self.supplier_id = supplier.id
      else
        supplier = Supplier.find_by(id: self.supplier_id)
        supplier.update(company_name: self.full_name) if supplier
      end
    else
      if self.customer_id.blank?
        customer = Customer.create!(contact_name: self.full_name)
        self.customer_id = customer.id
      else
        customer = Customer.find_by(id: self.customer_id)
        customer.update(contact_name: self.full_name) if customer
      end
    end
  end

  # admin kullanıcının supplier'ına ait ürünleri yönetebilir
  def can_manage_products?
    admin? && supplier.present?
  end

  def current_cart
    carts.find_or_create_by(status: "open")
  end  
end
