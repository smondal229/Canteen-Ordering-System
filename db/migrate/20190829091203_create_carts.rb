class CreateCarts < ActiveRecord::Migration[5.2]
  def change
    create_table :carts do |t|
      t.references :food_store, foreign_key: true, null: true
      t.references :employee, foreign_key: true
      t.integer :total_price
      t.datetime :placed_at
      t.datetime :delivered_at
    end
  end
end
