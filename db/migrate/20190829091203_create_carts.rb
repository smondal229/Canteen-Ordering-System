class CreateCarts < ActiveRecord::Migration[5.2]
  def change
    create_table :carts do |t|
      t.references :food_store, foreign_key: { on_delete: :cascade }, null: true
      t.references :employee, foreign_key: { on_delete: :cascade }
      t.integer :total_price
      t.datetime :placed_at
      t.datetime :delivered_at
    end
  end
end
