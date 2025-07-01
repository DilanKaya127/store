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
    + '.png'
end

Product.find_each do |product|
  filename = normalize_filename(product.product_name)
  product.update(featured_image: filename)
end

puts "🎉 featured_image alanları başarıyla güncellendi!"

Supplier.all.each do |supplier|
  # HANGİSİ DAHA İYİ?
  # User.create(email: supplier.email_address,
  #             password: 'password',
  #             role: "admin",
  #             supplier_id: supplier.id) unless User.exists?(email: supplier.email_address)
  User.create(email: "#{supplier.company_name.parameterize}@admin.com",
              password: "password",
              role: "admin",
              supplier_id: supplier.id)
end
puts "🎉 Tedarikçi kullanıcıları başarıyla oluşturuldu!"

Customer.all.each do |customer|
  # User.create(email: customer.email_address,
  #             password: 'password',
  #             role: "customer",
  #             customer_id: customer.id) unless User.exists?(email: customer.email_address)
  User.create(email: "#{customer.contact_name.parameterize}@user.com",
              password: "password",
              role: "customer")
end
puts "🎉 Müşteri kullanıcıları başarıyla oluşturuldu!"
