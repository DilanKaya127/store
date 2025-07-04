class Product < ApplicationRecord
    include Product::Notifications
    # ilişkiler
    belongs_to :category, foreign_key: "category_id", primary_key: "id", optional: true
    belongs_to :supplier, foreign_key: "supplier_id", primary_key: "id", optional: true

    has_many :subscribers, dependent: :destroy
    # has_many :order_details, foreign_key: 'product_id', dependent: :destroy
    # has_many :orders, through: :order_details, source: :order
    # has_many :reviews, foreign_key: 'product_id', dependent: :destroy
    has_one_attached :featured_image

    # alias
    alias_attribute :name, :product_name
    alias_attribute :stock, :units_in_stock
    alias_attribute :price, :unit_price
    # alias_attribute :image, :featured_image
    alias_attribute :description, :quantity_per_unit

    # validasyonlar
    validates :product_name, presence: true
    validates :unit_price, presence: true, numericality: { greater_than_or_equal_to: 0 }
    validates :units_in_stock, presence: true, numericality: { greater_than_or_equal_to: 0 }
end
