# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2021_12_23_060529) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "addresses", force: :cascade do |t|
    t.string "province"
    t.string "country"
    t.string "address1"
    t.string "zip"
    t.string "city"
    t.string "country_name"
    t.string "address2"
    t.string "addressable_type"
    t.bigint "addressable_id"
    t.index ["addressable_type", "addressable_id"], name: "index_addresses_on_addressable_type_and_addressable_id"
  end

  create_table "customers", force: :cascade do |t|
    t.string "shopify_id"
    t.string "email"
    t.boolean "accepts_marketing"
    t.string "first_name"
    t.string "last_name"
    t.integer "orders_count"
    t.string "state"
    t.string "total_spent"
    t.string "last_order_id"
    t.string "phone"
    t.string "addresses", default: [], array: true
    t.bigint "shop_id"
    t.index ["shop_id"], name: "index_customers_on_shop_id"
  end

  create_table "products", force: :cascade do |t|
    t.string "shopify_id"
    t.string "title"
    t.string "vendor"
    t.string "product_type"
    t.string "handle"
    t.string "status"
    t.bigint "shop_id", null: false
    t.index ["shop_id"], name: "index_products_on_shop_id"
  end

  create_table "shops", force: :cascade do |t|
    t.string "shopify_domain", null: false
    t.string "shopify_token", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "access_scopes"
    t.string "shopify_id"
    t.string "shopify_name"
    t.string "shopify_email"
    t.string "shopify_timezome"
    t.string "shopify_phone"
    t.index ["shopify_domain"], name: "index_shops_on_shopify_domain", unique: true
  end

  create_table "variants", force: :cascade do |t|
    t.string "shopify_id"
    t.string "title"
    t.string "fulfillment_service"
    t.boolean "taxable"
    t.string "barcode"
    t.float "grams"
    t.string "image_id"
    t.float "weight"
    t.string "weight_unit"
    t.string "inventory_item_id"
    t.integer "inventory_quantity"
    t.boolean "requires_shipping"
    t.bigint "product_id", null: false
    t.index ["product_id"], name: "index_variants_on_product_id"
  end

  add_foreign_key "customers", "shops"
  add_foreign_key "products", "shops"
  add_foreign_key "variants", "products"
end
