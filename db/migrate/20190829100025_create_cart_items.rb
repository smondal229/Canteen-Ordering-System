class CreateCartItems < ActiveRecord::Migration[5.2]
  def change
    create_table :cart_items do |t|
      t.integer :quantity, null: false, default: 1
      t.references :food, foreign_key: { on_delete: :cascade }
      t.text :description
      t.belongs_to :cart, foreign_key: { on_delete: :cascade }
      
      t.timestamps
    end
  end
end
