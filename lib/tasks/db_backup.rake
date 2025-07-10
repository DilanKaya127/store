# lib/tasks/db_backup.rake

namespace :db do
    desc "Backup the SQLite3 database (Northwind_large.sqlite) to db/backups/"
    task backup: :environment do
      require "fileutils"
  
      ts  = Time.now.strftime("%Y%m%d_%H%M%S")
      cfg = Rails.configuration.database_configuration[Rails.env]
  
      unless cfg["adapter"] == "sqlite3"
        abort "Yedekleme yalnızca sqlite3 için destekleniyor (şu an: #{cfg['adapter']})"
      end
  
      # database.yml içindeki path'i kullanıyoruz
      src_path = Rails.root.join(cfg["database"])
      unless File.exist?(src_path)
        abort "Kaynak dosya bulunamadı: #{src_path}"
      end
  
      # Örneğin Northwind_large.sqlite → Northwind_large_20250710_172530.sqlite
      base_name = File.basename(cfg["database"], File.extname(cfg["database"]))
      dest_path = Rails.root.join("db/backups/#{base_name}_#{ts}#{File.extname(cfg['database'])}")
  
      FileUtils.cp(src_path, dest_path)
      puts "✅ Yedek oluşturuldu: #{dest_path}"
    end
  end
  