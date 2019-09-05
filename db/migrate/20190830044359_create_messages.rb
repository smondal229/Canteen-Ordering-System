class CreateMessages < ActiveRecord::Migration[5.2]
  def change
    create_table :messages do |t|
      t.references :sendable, polymorphic: true
      t.references :recipientable, polymorphic: true
      t.text :body, null: false
      t.timestamps
    end
  end
end
