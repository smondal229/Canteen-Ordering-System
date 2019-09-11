class AddNullValidationsToTables < ActiveRecord::Migration[5.2]
  def change
    change_column :cart_items, :quantity, :integer, null: false, default: 1
    change_column :categories, :name, :string, null: false
    change_column :food_stores, :name, :string, null: false
  end
end
