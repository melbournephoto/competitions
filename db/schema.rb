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

ActiveRecord::Schema.define(version: 20131017205900) do

  create_table "competition_series", force: true do |t|
    t.string   "title"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "competition_series_grades", force: true do |t|
    t.integer  "competition_series_id", null: false
    t.integer  "grade_id",              null: false
    t.integer  "user_id",               null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "competition_series_grades", ["competition_series_id"], name: "index_competition_series_grades_on_competition_series_id", using: :btree
  add_index "competition_series_grades", ["grade_id"], name: "index_competition_series_grades_on_grade_id", using: :btree
  add_index "competition_series_grades", ["user_id"], name: "index_competition_series_grades_on_user_id", using: :btree

  create_table "competitions", force: true do |t|
    t.integer  "competition_series_id"
    t.string   "title"
    t.datetime "entries_open_at"
    t.datetime "entries_close_at"
    t.datetime "results_published_at"
    t.string   "judge_key"
    t.text     "notes"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "competitions", ["competition_series_id"], name: "index_competitions_on_competition_series_id", using: :btree

  create_table "entries", force: true do |t|
    t.integer  "user_id"
    t.integer  "competition_id"
    t.integer  "section_id"
    t.integer  "rating_id"
    t.integer  "grade_id"
    t.string   "title"
    t.string   "photo"
    t.text     "notes"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "entries", ["competition_id"], name: "index_entries_on_competition_id", using: :btree
  add_index "entries", ["grade_id"], name: "index_entries_on_grade_id", using: :btree
  add_index "entries", ["section_id"], name: "index_entries_on_section_id", using: :btree
  add_index "entries", ["user_id"], name: "index_entries_on_user_id", using: :btree

  create_table "grades", force: true do |t|
    t.string   "title"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "ratings", force: true do |t|
    t.string   "title"
    t.integer  "points",              default: 0, null: false
    t.integer  "max_per_grade",       default: 0, null: false
    t.integer  "max_per_competition", default: 0, null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "sections", force: true do |t|
    t.integer  "competition_id"
    t.string   "title"
    t.integer  "entry_limit"
    t.integer  "max_height"
    t.integer  "max_width"
    t.integer  "max_file_size"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "sections", ["competition_id"], name: "index_sections_on_competition_id", using: :btree

  create_table "users", force: true do |t|
    t.string   "email",                  default: "",    null: false
    t.string   "encrypted_password",     default: "",    null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "first_name"
    t.string   "last_name"
    t.boolean  "admin",                  default: false, null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

end
