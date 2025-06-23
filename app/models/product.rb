class Product < ApplicationRecord
    self.table_name = "Product"  # Northwind'de tablo adı büyük harfle
    self.primary_key = "Id"  # Northwind'de primary key bu

    # ilişkiler
    belongs_to :category, foreign_key: 'CategoryID', class_name: 'Category', optional: true
    belongs_to :supplier, foreign_key: 'SupplierID', class_name: 'Supplier', optional: true
    # has_many :order_details, foreign_key: 'ProductID', class_name: 'OrderDetail', dependent: :destroy
    # has_many :orders, through: :order_details, source: :order
    # has_many :reviews, foreign_key: 'ProductID', class_name: 'Review', dependent: :destroy
    # has_one_attached :FeaturedImage

    # alias
    alias_attribute :name, :ProductName
    alias_attribute :stock, :UnitsInStock
    alias_attribute :price, :UnitPrice
    # alias_attribute :image, :FeaturedImage
    alias_attribute :description, :QuantityPerUnit

    #validasyonlar
    validates :ProductName, presence: true
    validates :UnitPrice, presence: true, numericality: { greater_than_or_equal_to: 0 }
end