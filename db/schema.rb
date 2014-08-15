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

ActiveRecord::Schema.define(version: 20140815153221) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "available_dates", force: true do |t|
    t.integer  "listing_id", null: false
    t.date     "date",       null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "available_dates", ["listing_id"], name: "index_available_dates_on_listing_id", using: :btree

  create_table "listings", force: true do |t|
    t.string   "city"
    t.string   "address"
    t.integer  "price"
    t.string   "title"
    t.text     "description"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "accommodates",         default: 1
    t.integer  "property_category_id"
    t.integer  "room_category_id"
  end

  create_table "orders", force: true do |t|
    t.integer  "reservation_id",   null: false
    t.string   "stripe_charge_id", null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "orders", ["reservation_id"], name: "index_orders_on_reservation_id", using: :btree

  create_table "photos", force: true do |t|
    t.integer  "listing_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "image_file_name"
    t.string   "image_content_type"
    t.integer  "image_file_size"
    t.datetime "image_updated_at"
  end

  add_index "photos", ["listing_id"], name: "index_photos_on_listing_id", using: :btree

  create_table "property_categories", force: true do |t|
    t.string   "name",       null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "reservations", force: true do |t|
    t.integer  "listing_id", null: false
    t.integer  "user_id",    null: false
    t.date     "start_date", null: false
    t.date     "end_date",   null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "reservations", ["listing_id"], name: "index_reservations_on_listing_id", using: :btree
  add_index "reservations", ["user_id"], name: "index_reservations_on_user_id", using: :btree

  create_table "room_categories", force: true do |t|
    t.string   "name",       null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", force: true do |t|
    t.string   "email",              null: false
    t.string   "password_digest",    null: false
    t.datetime "created_at",         null: false
    t.datetime "updated_at",         null: false
    t.string   "stripe_customer_id"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree

end
