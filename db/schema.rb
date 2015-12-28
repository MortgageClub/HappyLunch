# encoding: UTF-8
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

ActiveRecord::Schema.define(version: 20151228073546) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "dishes", force: :cascade do |t|
    t.string  "name"
    t.decimal "price"
  end

  create_table "order_items", force: :cascade do |t|
    t.integer "dish_id"
  end

  add_index "order_items", ["dish_id"], name: "index_order_items_on_dish_id", using: :btree

  create_table "orders", force: :cascade do |t|
    t.datetime "order_date"
    t.string   "description"
  end

  add_foreign_key "order_items", "dishes"
end
