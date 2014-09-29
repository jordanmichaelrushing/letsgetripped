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

ActiveRecord::Schema.define(version: 20140929125847) do

  create_table "calf_crunches", force: true do |t|
    t.string   "set_type",   default: "Crunch"
    t.integer  "set_num",    default: 0
    t.integer  "reps",       default: 0
    t.integer  "day_id"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "cardios", force: true do |t|
    t.string   "name"
    t.string   "notes"
    t.float    "duration",                  limit: 24
    t.float    "distance",                  limit: 24
    t.float    "sixty_percent_speed",       limit: 24
    t.float    "eighty_percent_speed",      limit: 24
    t.float    "ninety_percent_speed",      limit: 24
    t.float    "one_hundred_percent_speed", limit: 24
    t.integer  "times_walked"
    t.integer  "day_id"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "days", force: true do |t|
    t.datetime "date"
    t.string   "img_url"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "exercises", force: true do |t|
    t.string   "notes"
    t.string   "name"
    t.string   "img_url"
    t.float    "set_one_weight",   limit: 24
    t.float    "set_two_weight",   limit: 24
    t.float    "set_three_weight", limit: 24
    t.float    "set_four_weight",  limit: 24
    t.integer  "amrap_quantity"
    t.integer  "day_id"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.datetime "date"
  end

  create_table "meals", force: true do |t|
    t.string   "name"
    t.string   "notes"
    t.float    "protein",        limit: 24
    t.float    "carbs",          limit: 24
    t.float    "fats",           limit: 24
    t.float    "sugar",          limit: 24
    t.float    "sodium",         limit: 24
    t.float    "saturated_fats", limit: 24
    t.float    "cholesterol",    limit: 24
    t.float    "fiber",          limit: 24
    t.integer  "meal_number"
    t.integer  "day_id"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "pushups", force: true do |t|
    t.integer  "set_one_reps"
    t.integer  "set_two_reps"
    t.string   "set_three_reps"
    t.integer  "day_id"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "super_challenges", force: true do |t|
    t.string   "notes"
    t.float    "push_ups",     limit: 24
    t.float    "pull_ups",     limit: 24
    t.float    "duration",     limit: 24
    t.float    "distance",     limit: 24
    t.integer  "times_walked"
    t.integer  "day_id"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.datetime "date"
  end

  create_table "users", force: true do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "name"
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
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
