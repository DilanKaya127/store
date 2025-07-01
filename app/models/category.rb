class Category < ApplicationRecord
    # ilişkiler
    belongs_to :product, optional: true

    # alias
    alias_attribute :name, :category_name

    # validasyonlar
    validates :category_name, presence: true
end
