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

ActiveRecord::Schema.define(version: 20140418075456) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "notifications", force: true do |t|
    t.boolean  "action",            default: false
    t.string   "notification_type",                 null: false
    t.text     "data"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "user_id"
    t.integer  "user_shift_id"
  end

  create_table "schedules", force: true do |t|
    t.boolean  "published"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "shift_change_requests", force: true do |t|
    t.integer  "initiator_id",           null: false
    t.integer  "original_user_id"
    t.integer  "original_user_shift_id"
    t.integer  "original_shift_id"
    t.integer  "target_user_id"
    t.integer  "target_user_shift_id"
    t.integer  "target_shift_id"
    t.integer  "reference_request_id"
    t.string   "status"
    t.string   "kind"
    t.text     "reason"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "shifts", force: true do |t|
    t.datetime "start_at", null: false
    t.datetime "end_at"
  end

  create_table "user_shifts", force: true do |t|
    t.integer "user_id",   null: false
    t.integer "shift_id",  null: false
    t.boolean "scheduled"
  end

  create_table "users", force: true do |t|
    t.string   "name"
    t.string   "phone_number",           default: ""
    t.boolean  "admin",                  default: false
    t.string   "email",                  default: "",    null: false
    t.string   "encrypted_password",     default: "",    null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,     null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

end
