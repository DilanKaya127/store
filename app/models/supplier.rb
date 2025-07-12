class Supplier < ApplicationRecord
  has_many :users, foreign_key: "supplier_id", primary_key: "id", dependent: :destroy
  has_many :products, foreign_key: "supplier_id", primary_key: "id", dependent: :destroy

  validates :company_name, presence: true
  # validates :email_address, presence: true, uniqueness: true

  # normalizes :email_address, with: ->(e) { e.strip.downcase }
end
