class CreateEmployees < ActiveRecord::Migration[5.2]
  def change
    create_table :employees do |t|
      t.string :provider
      t.string :uid
      t.string :name
      t.string :email, null: false
      t.string :password_digest
      t.string :phone
      t.string :oauth_token
      t.datetime :oauth_expires_at
      t.references :company, foreign_key: { on_delete: :cascade }
    end

    add_index :employees, :email, unique: true
  end
end
