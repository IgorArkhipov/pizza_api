# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.0].define(version: 2023_01_21_213829) do
  create_table "discounts", force: :cascade do |t|
    t.string "name"
    t.float "deduction_in_percent"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name"], name: "index_discounts_on_name", unique: true
  end

  create_table "ingredients", force: :cascade do |t|
    t.string "name"
    t.float "price"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name"], name: "index_ingredients_on_name", unique: true
  end

  create_table "order_pizza_ingredients", force: :cascade do |t|
    t.integer "order_pizza_id", null: false
    t.integer "ingredient_id", null: false
    t.string "action_type", limit: 7, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["ingredient_id"], name: "index_order_pizza_ingredients_on_ingredient_id"
    t.index ["order_pizza_id"], name: "index_order_pizza_ingredients_on_order_pizza_id"
  end

# Could not dump table "order_pizzas" because of following StandardError
#   Unknown type 'uuid' for column 'order_id'

# Could not dump table "order_promotions" because of following StandardError
#   Unknown type 'uuid' for column 'order_id'

# Could not dump table "orders" because of following StandardError
#   Unknown type 'uuid' for column 'id'

  create_table "pizzas", force: :cascade do |t|
    t.string "name"
    t.float "price"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name"], name: "index_pizzas_on_name", unique: true
  end

  create_table "promotions", force: :cascade do |t|
    t.string "name"
    t.integer "from"
    t.integer "to"
    t.integer "pizza_id", null: false
    t.integer "size_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name"], name: "index_promotions_on_name", unique: true
    t.index ["pizza_id"], name: "index_promotions_on_pizza_id"
    t.index ["size_id"], name: "index_promotions_on_size_id"
  end

  create_table "sizes", force: :cascade do |t|
    t.string "name"
    t.float "multiplier"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name"], name: "index_sizes_on_name", unique: true
  end

  add_foreign_key "order_pizza_ingredients", "ingredients"
  add_foreign_key "order_pizza_ingredients", "order_pizzas"
  add_foreign_key "order_pizzas", "orders"
  add_foreign_key "order_pizzas", "pizzas"
  add_foreign_key "order_pizzas", "sizes"
  add_foreign_key "order_promotions", "orders"
  add_foreign_key "order_promotions", "promotions"
  add_foreign_key "orders", "discounts"
  add_foreign_key "promotions", "pizzas"
  add_foreign_key "promotions", "sizes"
end
