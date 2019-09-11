class AddTimestampsToTables < ActiveRecord::Migration[5.2]
  def change
    add_timestamps :admins,         default: Time.now
    add_timestamps :cart_items,     default: Time.now
    add_timestamps :categories,     default: Time.now
    add_timestamps :chefs,          default: Time.now
    add_timestamps :companies,      default: Time.now
    add_timestamps :employees,      default: Time.now
    add_timestamps :food_galleries, default: Time.now
    add_timestamps :food_stores,    default: Time.now
    add_timestamps :foods,          default: Time.now
    add_timestamps :statuses,       default: Time.now
  end
end
