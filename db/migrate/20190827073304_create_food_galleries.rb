class CreateFoodGalleries < ActiveRecord::Migration[5.2]
  def change
    create_table :food_galleries do |t|
      t.references :food_store, foreign_key: { on_delete: :cascade }
      t.text :description
      
      t.timestamps
    end
  end
end
