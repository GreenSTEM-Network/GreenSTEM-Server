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

ActiveRecord::Schema.define(version: 20140606165416) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "collection_points", force: true do |t|
    t.text     "name"
    t.integer  "site_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "data_collections", force: true do |t|
    t.datetime "created_at",          null: false
    t.datetime "updated_at",          null: false
    t.integer  "collection_point_id"
    t.datetime "collection_time"
  end

  create_table "node_readings", force: true do |t|
    t.integer  "node_id"
    t.decimal  "soil1"
    t.decimal  "soil2"
    t.decimal  "soil3"
    t.integer  "temp"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "node_readings", ["node_id"], name: "index_node_readings_on_node_id", using: :btree

  create_table "nodes", force: true do |t|
    t.integer  "channel"
    t.string   "project_type"
    t.decimal  "voltage"
    t.integer  "site_id"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
    t.boolean  "is_disabled"
  end

  add_index "nodes", ["site_id"], name: "index_nodes_on_site_id", using: :btree

  create_table "rails_admin_histories", force: true do |t|
    t.text     "message"
    t.string   "username"
    t.integer  "item"
    t.string   "table"
    t.integer  "month",      limit: 2
    t.integer  "year",       limit: 8
    t.datetime "created_at",           null: false
    t.datetime "updated_at",           null: false
  end

  add_index "rails_admin_histories", ["item", "table", "month", "year"], name: "index_rails_admin_histories", using: :btree

  create_table "roles", force: true do |t|
    t.string   "name"
    t.integer  "resource_id"
    t.string   "resource_type"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
  end

  add_index "roles", ["name", "resource_type", "resource_id"], name: "index_roles_on_name_and_resource_type_and_resource_id", using: :btree
  add_index "roles", ["name"], name: "index_roles_on_name", using: :btree

  create_table "sites", force: true do |t|
    t.string   "name"
    t.text     "description"
    t.string   "address"
    t.string   "zipcode"
    t.datetime "created_at",          null: false
    t.datetime "updated_at",          null: false
    t.integer  "weather_location_id"
    t.integer  "soil_type_id"
  end

  create_table "soil_types", force: true do |t|
    t.string   "name"
    t.text     "description"
    t.decimal  "moist_threshold"
    t.decimal  "wilting_threshold"
    t.datetime "created_at",        null: false
    t.datetime "updated_at",        null: false
  end

  create_table "soilmoistures", force: true do |t|
    t.float    "deptha"
    t.float    "depthb"
    t.float    "depthc"
    t.datetime "created_at",          null: false
    t.datetime "updated_at",          null: false
    t.integer  "collection_point_id"
    t.datetime "collection_time"
  end

  create_table "users", force: true do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.string   "name"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

  create_table "users_roles", id: false, force: true do |t|
    t.integer "user_id"
    t.integer "role_id"
  end

  add_index "users_roles", ["user_id", "role_id"], name: "index_users_roles_on_user_id_and_role_id", using: :btree

  create_table "weather_locations", force: true do |t|
    t.string   "name"
    t.text     "description"
    t.decimal  "lat",         precision: 9, scale: 6
    t.decimal  "lon",         precision: 9, scale: 6
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
  end

end
