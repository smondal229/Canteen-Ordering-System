# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2019_09_04_055927) do

  create_table "admins", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "email", null: false
    t.string "password_digest"
  end

  create_table "cart_items", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.integer "quantity", default: 1
    t.bigint "food_id"
    t.text "description"
    t.bigint "cart_id"
    t.index ["cart_id"], name: "index_cart_items_on_cart_id"
    t.index ["food_id"], name: "index_cart_items_on_food_id"
  end

  create_table "carts", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.bigint "food_store_id"
    t.bigint "employee_id"
    t.integer "total_price"
    t.datetime "placed_at"
    t.datetime "delivered_at"
    t.bigint "status_id"
    t.integer "priority"
    t.index ["employee_id"], name: "index_carts_on_employee_id"
    t.index ["food_store_id"], name: "index_carts_on_food_store_id"
    t.index ["status_id"], name: "index_carts_on_status_id"
  end

  create_table "categories", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "name"
    t.index ["name"], name: "index_categories_on_name", unique: true
  end

  create_table "chefs", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "provider"
    t.string "uid"
    t.string "name"
    t.string "email", null: false
    t.string "password_digest"
    t.string "phone"
    t.text "oauth_token"
    t.datetime "oauth_expires_at"
    t.bigint "food_store_id"
    t.boolean "approved"
    t.boolean "order_notification_visible", default: true
    t.index ["email"], name: "index_chefs_on_email", unique: true
    t.index ["food_store_id"], name: "index_chefs_on_food_store_id"
  end

  create_table "companies", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "name", null: false
    t.index ["name"], name: "index_companies_on_name", unique: true
  end

  create_table "employees", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "provider"
    t.string "uid"
    t.string "name"
    t.string "email", null: false
    t.string "password_digest"
    t.string "phone"
    t.string "oauth_token"
    t.datetime "oauth_expires_at"
    t.bigint "company_id"
    t.boolean "approved"
    t.boolean "order_notification_visible", default: true
    t.index ["company_id"], name: "index_employees_on_company_id"
    t.index ["email"], name: "index_employees_on_email", unique: true
  end

  create_table "food_galleries", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.bigint "food_store_id"
    t.text "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "image_file_name"
    t.string "image_content_type"
    t.bigint "image_file_size"
    t.datetime "image_updated_at"
    t.index ["food_store_id"], name: "index_food_galleries_on_food_store_id"
  end

  create_table "food_stores", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "name"
    t.index ["name"], name: "index_food_stores_on_name", unique: true
  end

  create_table "foods", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "name", null: false
    t.integer "price", null: false
    t.bigint "food_store_id"
    t.bigint "category_id"
    t.index ["category_id"], name: "index_foods_on_category_id"
    t.index ["food_store_id"], name: "index_foods_on_food_store_id"
    t.index ["name", "food_store_id"], name: "index_foods_on_name_and_food_store_id", unique: true
  end

  create_table "messages", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "sendable_type"
    t.bigint "sendable_id"
    t.string "recipientable_type"
    t.bigint "recipientable_id"
    t.text "body", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["recipientable_type", "recipientable_id"], name: "index_messages_on_recipientable_type_and_recipientable_id"
    t.index ["sendable_type", "sendable_id"], name: "index_messages_on_sendable_type_and_sendable_id"
  end

  create_table "notifications", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.text "content"
    t.string "notifiable_type"
    t.bigint "notifiable_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["notifiable_type", "notifiable_id"], name: "index_notifications_on_notifiable_type_and_notifiable_id"
  end

  create_table "statuses", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "name", null: false
    t.index ["name"], name: "index_statuses_on_name", unique: true
  end

  add_foreign_key "cart_items", "carts", on_delete: :cascade
  add_foreign_key "cart_items", "foods", on_delete: :cascade
  add_foreign_key "carts", "employees"
  add_foreign_key "carts", "food_stores"
  add_foreign_key "carts", "statuses", on_delete: :cascade
  add_foreign_key "chefs", "food_stores"
  add_foreign_key "employees", "companies"
  add_foreign_key "food_galleries", "food_stores"
  add_foreign_key "foods", "categories", on_delete: :cascade
  add_foreign_key "foods", "food_stores", on_delete: :cascade
end
