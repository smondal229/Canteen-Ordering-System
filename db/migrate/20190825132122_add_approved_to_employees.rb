class AddApprovedToEmployees < ActiveRecord::Migration[5.2]
  def change
    add_column :employees, :approved, :boolean
    change_column :employees, :company_id, :bigint, null: true
  end
end
