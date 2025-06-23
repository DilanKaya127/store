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

ActiveRecord::Schema[8.0].define(version: 2025_06_23_185204) do
  create_table "Category", primary_key: "Id", force: :cascade do |t|
    t.string "CategoryName", limit: 8000
    t.string "Description", limit: 8000
  end

  create_table "Customer", primary_key: "Id", id: { type: :string, limit: 8000 }, force: :cascade do |t|
    t.string "CompanyName", limit: 8000
    t.string "ContactName", limit: 8000
    t.string "ContactTitle", limit: 8000
    t.string "Address", limit: 8000
    t.string "City", limit: 8000
    t.string "Region", limit: 8000
    t.string "PostalCode", limit: 8000
    t.string "Country", limit: 8000
    t.string "Phone", limit: 8000
    t.string "Fax", limit: 8000
  end

  create_table "CustomerCustomerDemo", primary_key: "Id", id: { type: :string, limit: 8000 }, force: :cascade do |t|
    t.string "CustomerTypeId", limit: 8000
  end

  create_table "CustomerDemographic", primary_key: "Id", id: { type: :string, limit: 8000 }, force: :cascade do |t|
    t.string "CustomerDesc", limit: 8000
  end

  create_table "Employee", primary_key: "Id", force: :cascade do |t|
    t.string "LastName", limit: 8000
    t.string "FirstName", limit: 8000
    t.string "Title", limit: 8000
    t.string "TitleOfCourtesy", limit: 8000
    t.string "BirthDate", limit: 8000
    t.string "HireDate", limit: 8000
    t.string "Address", limit: 8000
    t.string "City", limit: 8000
    t.string "Region", limit: 8000
    t.string "PostalCode", limit: 8000
    t.string "Country", limit: 8000
    t.string "HomePhone", limit: 8000
    t.string "Extension", limit: 8000
    t.binary "Photo"
    t.string "Notes", limit: 8000
    t.integer "ReportsTo"
    t.string "PhotoPath", limit: 8000
  end

  create_table "EmployeeTerritory", primary_key: "Id", id: { type: :string, limit: 8000 }, force: :cascade do |t|
    t.integer "EmployeeId", null: false
    t.string "TerritoryId", limit: 8000
  end

  create_table "Order", primary_key: "Id", force: :cascade do |t|
    t.string "CustomerId", limit: 8000
    t.integer "EmployeeId", null: false
    t.string "OrderDate", limit: 8000
    t.string "RequiredDate", limit: 8000
    t.string "ShippedDate", limit: 8000
    t.integer "ShipVia"
    t.decimal "Freight", null: false
    t.string "ShipName", limit: 8000
    t.string "ShipAddress", limit: 8000
    t.string "ShipCity", limit: 8000
    t.string "ShipRegion", limit: 8000
    t.string "ShipPostalCode", limit: 8000
    t.string "ShipCountry", limit: 8000
  end

  create_table "OrderDetail", primary_key: "Id", id: { type: :string, limit: 8000 }, force: :cascade do |t|
    t.integer "OrderId", null: false
    t.integer "ProductId", null: false
    t.decimal "UnitPrice", null: false
    t.integer "Quantity", null: false
    t.float "Discount", null: false
  end

  create_table "Product", primary_key: "Id", force: :cascade do |t|
    t.string "ProductName", limit: 8000
    t.integer "SupplierId", null: false
    t.integer "CategoryId", null: false
    t.string "QuantityPerUnit", limit: 8000
    t.decimal "UnitPrice", null: false
    t.integer "UnitsInStock", null: false
    t.integer "UnitsOnOrder", null: false
    t.integer "ReorderLevel", null: false
    t.integer "Discontinued", null: false
  end

  create_table "Region", primary_key: "Id", force: :cascade do |t|
    t.string "RegionDescription", limit: 8000
  end

  create_table "Shipper", primary_key: "Id", force: :cascade do |t|
    t.string "CompanyName", limit: 8000
    t.string "Phone", limit: 8000
  end

  create_table "Supplier", primary_key: "Id", force: :cascade do |t|
    t.string "CompanyName", limit: 8000
    t.string "ContactName", limit: 8000
    t.string "ContactTitle", limit: 8000
    t.string "Address", limit: 8000
    t.string "City", limit: 8000
    t.string "Region", limit: 8000
    t.string "PostalCode", limit: 8000
    t.string "Country", limit: 8000
    t.string "Phone", limit: 8000
    t.string "Fax", limit: 8000
    t.string "HomePage", limit: 8000
  end

  create_table "Territory", primary_key: "Id", id: { type: :string, limit: 8000 }, force: :cascade do |t|
    t.string "TerritoryDescription", limit: 8000
    t.integer "RegionId", null: false
  end

  create_table "sessions", force: :cascade do |t|
    t.integer "user_id", null: false
    t.string "ip_address"
    t.string "user_agent"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_sessions_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email_address", null: false
    t.string "password_digest", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email_address"], name: "index_users_on_email_address", unique: true
  end

  add_foreign_key "sessions", "users"
end
