# lib/tasks/attach_images.rake
namespace :products do
  desc "Attach images to products based on sanitized name"
  task attach_images: :environment do
    Product.find_each do |product|
      # ⛔ Atla: Zaten görsel atanmışsa
      if product.featured_image.attached?
        puts "⏭️ Skipping #{product.name}, already has an image"
        next
      end
      
      sanitized_name = product.name
        .downcase
        .tr("ğüşıöç", "gusioc")    # Türkçe karakter dönüşümü
        .gsub(/['`’]/, "")         # Tek tırnakları ve benzerlerini sil
        .parameterize              # Boşlukları tire yap, özel karakterleri kaldır

      filename = "#{sanitized_name}.png"
      path = Rails.root.join("app/assets/images/products", filename)

      if File.exist?(path)
        product.featured_image.attach(io: File.open(path), filename: filename)
        puts "✅ Attached #{filename} to #{product.name}"
      else
        puts "⚠️  No image found for #{product.name} (expected #{filename})"
      end
    end
  end
end
