class CreateFavorites < ActiveRecord::Migration[8.0]
  def change
    create_table :favorites do |t|
      t.references :user, null: false, foreign_key: true
      t.references :product, null: false, foreign_key: true

      t.timestamps
    end
    add_index :favorites, [ :user_id, :product_id ], unique: true # aynı ürünün iki kere favorilenmemesi için
  end
end
