class CreateCarts < ActiveRecord::Migration[8.0]
  def change
    create_table :carts do |t|
      t.references :user, null: false, foreign_key: true
      t.string :status, default: "open"
      t.datetime :checked_out_at
      t.decimal :total_price, precision: 10, scale: 2
      t.boolean :discount_applied, default: false
      t.timestamps
    end
  end
end
