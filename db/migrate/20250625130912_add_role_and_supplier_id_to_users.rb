class AddRoleAndsupplier_idToUsers < ActiveRecord::Migration[8.0]
  def change
    add_column :users, :role, :string
    add_column :users, :supplier_id, :integer
  end
end
