class Customer < ApplicationRecord
  has_many :users, foreign_key: "customer_id", primary_key: "id"

  validates :contact_name, presence: true
end
