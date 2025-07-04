class AddProductToSubscribers < ActiveRecord::Migration[8.0]
  def change
    add_reference :subscribers, :product, null: false, foreign_key: true
  end
end
