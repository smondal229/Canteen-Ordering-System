class AddApprovedToChefs < ActiveRecord::Migration[5.2]
  def change
    add_column :chefs, :approved, :boolean
    change_column :chefs, :food_store_id, :bigint, null: true
  end
end
