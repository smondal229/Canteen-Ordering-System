class CreateStatuses < ActiveRecord::Migration[5.2]
  def change
    create_table :statuses do |t|
      t.string :name, null: false
    end
    add_index :statuses, :name, unique: true
  end
end
