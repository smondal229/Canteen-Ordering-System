class CreateChefs < ActiveRecord::Migration[5.2]
  def change
    create_table :chefs do |t|
      t.string :provider
      t.string :uid
      t.string :name
      t.string :email, null: false
      t.string :password_digest
      t.string :phone
      t.text :oauth_token
      t.datetime :oauth_expires_at
      t.references :food_store, foreign_key: true
    end

    add_index :chefs, :email, unique: true
  end
end
