# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

require 'active_support/inflector/transliterate'

def normalize_filename(name)
  name
    .parameterize(separator: '-')       # kebab-case'e çevir
    .gsub(/[^a-z0-9\-]/, '')            # istenmeyen karakterleri temizle
    + '.svg'
end

Product.find_each do |product|
  filename = normalize_filename(product.ProductName)
  product.update(FeaturedImage: filename)
end

puts "🎉 FeaturedImage alanları başarıyla güncellendi!"
