class CreateFoodStores < ActiveRecord::Migration[5.2]
  def change
    create_table :food_stores do |t|
      t.string :name
    end
    
    add_index :food_stores, :name, unique: true
  end
end
