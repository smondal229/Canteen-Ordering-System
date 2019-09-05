class AddStatusReferencesToCarts < ActiveRecord::Migration[5.2]
  def change
    add_reference :carts, :status, foreign_key: { on_delete: :cascade }, null: true
    add_column :carts, :priority, :integer
  end
end
