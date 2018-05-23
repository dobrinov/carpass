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

ActiveRecord::Schema.define(version: 20180523203415) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "api_keys", force: :cascade do |t|
    t.string   "access_token", null: false
    t.integer  "user_id",      null: false
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  create_table "brands", force: :cascade do |t|
    t.string "name"
  end

  create_table "car_services", force: :cascade do |t|
    t.string   "license"
    t.string   "details"
    t.string   "type"
    t.integer  "location_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  add_index "car_services", ["location_id"], name: "index_car_services_on_location_id", using: :btree

  create_table "cars", force: :cascade do |t|
    t.string   "vin"
    t.string   "plate"
    t.string   "engine_number"
    t.integer  "user_id"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
    t.string   "model"
    t.integer  "brand_id"
  end

  add_index "cars", ["brand_id"], name: "index_cars_on_brand_id", using: :btree

  create_table "histories", force: :cascade do |t|
    t.integer  "mileage"
    t.decimal  "cost",        precision: 8, scale: 2
    t.string   "details"
    t.integer  "car_id"
    t.string   "type"
    t.datetime "valid_until"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.datetime "happened_at"
  end

  create_table "locations", force: :cascade do |t|
    t.string   "name"
    t.string   "settlement"
    t.integer  "settlement_type"
    t.string   "address"
    t.float    "longitude"
    t.float    "latitude"
    t.datetime "created_at",                    null: false
    t.datetime "updated_at",                    null: false
    t.string   "status",          default: "0", null: false
  end

  create_table "notifications", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "notifiable_id"
    t.string   "notifiable_type"
    t.datetime "read_at"
    t.string   "type"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
  end

  add_index "notifications", ["notifiable_id", "notifiable_type"], name: "index_notifications_on_notifiable_id_and_notifiable_type", using: :btree

  create_table "settings", force: :cascade do |t|
    t.integer "user_id"
    t.boolean "receives_history_expiration_emails",                 default: false
    t.boolean "receives_inactivity_emails",                         default: false
    t.boolean "receives_history_expiration_facebook_notifications", default: true
    t.boolean "receives_inactivity_facebook_notifications",         default: true
  end

  create_table "users", force: :cascade do |t|
    t.string   "provider"
    t.string   "uid"
    t.string   "email"
    t.string   "password_digest"
    t.boolean  "admin"
    t.datetime "last_login_at"
    t.datetime "created_at",                         null: false
    t.datetime "updated_at",                         null: false
    t.string   "password_reset_token"
    t.datetime "password_reset_sent_at"
    t.boolean  "guest"
    t.integer  "login_count",            default: 0, null: false
  end

end
