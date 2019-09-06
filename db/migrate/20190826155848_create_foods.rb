class CreateFoods < ActiveRecord::Migration[5.2]
  def change
    create_table :foods do |t|
      t.string :name, null: false
      t.integer :price, null: false
      t.references :food_store, foreign_key: { on_delete: :cascade }
      t.references :category, foreign_key: { on_delete: :cascade }
    end
    
    add_index :foods, [:name, :food_store_id], unique: true
  end
end
