# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[8.0].define(version: 2025_07_17_093025) do
  create_table "action_text_rich_texts", force: :cascade do |t|
    t.string "name", null: false
    t.text "body"
    t.string "record_type", null: false
    t.bigint "record_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["record_type", "record_id", "name"], name: "index_action_text_rich_texts_uniqueness", unique: true
  end

  create_table "active_storage_attachments", force: :cascade do |t|
    t.string "name", null: false
    t.string "record_type", null: false
    t.bigint "record_id", null: false
    t.bigint "blob_id", null: false
    t.datetime "created_at", null: false
    t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
    t.index ["record_type", "record_id", "name", "blob_id"], name: "index_active_storage_attachments_uniqueness", unique: true
  end

  create_table "active_storage_blobs", force: :cascade do |t|
    t.string "key", null: false
    t.string "filename", null: false
    t.string "content_type"
    t.text "metadata"
    t.string "service_name", null: false
    t.bigint "byte_size", null: false
    t.string "checksum"
    t.datetime "created_at", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "active_storage_variant_records", force: :cascade do |t|
    t.bigint "blob_id", null: false
    t.string "variation_digest", null: false
    t.index ["blob_id", "variation_digest"], name: "index_active_storage_variant_records_uniqueness", unique: true
  end

  create_table "cart_items", force: :cascade do |t|
    t.integer "cart_id", null: false
    t.integer "product_id", null: false
    t.integer "quantity", default: 1, null: false
    t.decimal "unit_price", precision: 10, scale: 2
    t.decimal "total_price", precision: 10, scale: 2
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["cart_id"], name: "index_cart_items_on_cart_id"
    t.index ["product_id"], name: "index_cart_items_on_product_id"
  end

  create_table "carts", force: :cascade do |t|
    t.integer "user_id"
    t.string "status", default: "open"
    t.datetime "checked_out_at"
    t.decimal "total_price", precision: 10, scale: 2
    t.boolean "discount_applied", default: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "session_id"
    t.index ["user_id"], name: "index_carts_on_user_id"
  end

  create_table "categories", force: :cascade do |t|
    t.string "category_name", limit: 8000
    t.string "description", limit: 8000
  end

  create_table "customer_customer_demos", id: { type: :string, limit: 8000 }, force: :cascade do |t|
    t.string "customer_type_id", limit: 8000
  end

  create_table "customer_demographics", id: { type: :string, limit: 8000 }, force: :cascade do |t|
    t.string "customer_desc", limit: 8000
  end

  create_table "customers", force: :cascade do |t|
    t.string "company_name", limit: 8000
    t.string "contact_name", limit: 8000
    t.string "contact_title", limit: 8000
    t.string "address", limit: 8000
    t.string "city", limit: 8000
    t.string "region", limit: 8000
    t.string "postal_code", limit: 8000
    t.string "country", limit: 8000
    t.string "phone", limit: 8000
    t.string "fax", limit: 8000
  end

  create_table "employee_territories", id: { type: :string, limit: 8000 }, force: :cascade do |t|
    t.integer "employee_id", null: false
    t.string "territory_id", limit: 8000
  end

  create_table "employees", force: :cascade do |t|
    t.string "last_name", limit: 8000
    t.string "first_name", limit: 8000
    t.string "title", limit: 8000
    t.string "title_of_courtesy", limit: 8000
    t.string "birth_date", limit: 8000
    t.string "hire_date", limit: 8000
    t.string "address", limit: 8000
    t.string "city", limit: 8000
    t.string "region", limit: 8000
    t.string "postal_code", limit: 8000
    t.string "country", limit: 8000
    t.string "home_phone", limit: 8000
    t.string "extension", limit: 8000
    t.binary "photo"
    t.string "notes", limit: 8000
    t.integer "reports_to"
    t.string "photo_path", limit: 8000
  end

  create_table "favorites", force: :cascade do |t|
    t.integer "user_id", null: false
    t.integer "product_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["product_id"], name: "index_favorites_on_product_id"
    t.index ["user_id", "product_id"], name: "index_favorites_on_user_id_and_product_id", unique: true
    t.index ["user_id"], name: "index_favorites_on_user_id"
  end

  create_table "order_details", id: { type: :string, limit: 8000 }, force: :cascade do |t|
    t.integer "order_id", null: false
    t.integer "product_id", null: false
    t.decimal "unit_price", null: false
    t.integer "quantity", null: false
    t.float "discount", null: false
  end

  create_table "orders", force: :cascade do |t|
    t.integer "customer_id", null: false
    t.integer "employee_id", null: false
    t.string "order_date", limit: 8000
    t.string "required_date", limit: 8000
    t.string "shipped_date", limit: 8000
    t.integer "ship_via"
    t.decimal "freight", null: false
    t.string "ship_name", limit: 8000
    t.string "ship_address", limit: 8000
    t.binary "ship_city"
    t.string "ship_region", limit: 8000
    t.string "ship_postal_code", limit: 8000
    t.string "ship_country", limit: 8000
  end

  create_table "products", force: :cascade do |t|
    t.string "product_name", limit: 8000
    t.integer "supplier_id", null: false
    t.integer "category_id", null: false
    t.string "quantity_per_unit", limit: 8000
    t.decimal "unit_price", null: false
    t.integer "units_in_stock", null: false
    t.integer "units_in_order", null: false
    t.integer "reorder_level", null: false
    t.integer "discontinued", null: false
    t.text "featured_image"
  end

  create_table "regions", force: :cascade do |t|
    t.string "region_description", limit: 8000
  end

  create_table "sessions", force: :cascade do |t|
    t.integer "user_id", null: false
    t.string "ip_address"
    t.string "user_agent"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_sessions_on_user_id"
  end

  create_table "shippers", force: :cascade do |t|
    t.string "company_name", limit: 8000
    t.string "phone", limit: 8000
  end

  create_table "subscribers", force: :cascade do |t|
    t.string "email"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "product_id", null: false
    t.index ["product_id"], name: "index_subscribers_on_product_id"
  end

  create_table "suppliers", force: :cascade do |t|
    t.string "company_name", limit: 8000
    t.string "contact_name", limit: 8000
    t.string "contact_title", limit: 8000
    t.string "address", limit: 8000
    t.string "city", limit: 8000
    t.string "region", limit: 8000
    t.string "postal_code", limit: 8000
    t.string "country", limit: 8000
    t.string "phone", limit: 8000
    t.string "fax", limit: 8000
    t.string "home_page", limit: 8000
  end

  create_table "territories", id: { type: :string, limit: 8000 }, force: :cascade do |t|
    t.string "territory_description", limit: 8000
    t.integer "region_id", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "email_address", null: false
    t.string "password_digest", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "role"
    t.integer "supplier_id"
    t.integer "customer_id"
    t.string "full_name"
    t.index ["customer_id"], name: "index_users_on_customer_id"
    t.index ["email_address"], name: "index_users_on_email_address", unique: true
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "active_storage_variant_records", "active_storage_blobs", column: "blob_id"
  add_foreign_key "cart_items", "carts"
  add_foreign_key "cart_items", "products"
  add_foreign_key "carts", "users"
  add_foreign_key "favorites", "products"
  add_foreign_key "favorites", "users"
  add_foreign_key "sessions", "users"
  add_foreign_key "subscribers", "products"
end
