class AddOrderNotificationVisibleToChefs < ActiveRecord::Migration[5.2]
  def change
    add_column :chefs, :order_notification_visible, :boolean, default: true
  end
end
