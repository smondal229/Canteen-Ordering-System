class AddOrderNotificationVisibleToEmployees < ActiveRecord::Migration[5.2]
  def change
    add_column :employees, :order_notification_visible, :boolean, default: true
  end
end
