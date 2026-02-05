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

ActiveRecord::Schema[8.0].define(version: 2026_02_04_000352) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "pg_catalog.plpgsql"

  create_table "products", force: :cascade do |t|
    t.string "product_id", null: false
    t.string "name", null: false
    t.text "description"
    t.string "category", null: false
    t.string "brand", null: false
    t.decimal "price", precision: 10, scale: 2, null: false
    t.decimal "old_price", precision: 10, scale: 2
    t.integer "stock", default: 0, null: false
    t.text "tags"
    t.string "image_url"
    t.boolean "active", default: true, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.tsvector "search_vector"
    t.index ["active", "created_at"], name: "index_products_on_active_and_created_at"
    t.index ["brand"], name: "index_products_on_brand"
    t.index ["category"], name: "index_products_on_category"
    t.index ["name"], name: "index_products_on_name"
    t.index ["price"], name: "index_products_on_price"
    t.index ["product_id"], name: "index_products_on_product_id", unique: true
    t.index ["search_vector"], name: "index_products_on_search_vector", using: :gin
  end
end
