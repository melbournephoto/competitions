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

ActiveRecord::Schema.define(version: 20171105000942) do

  create_table "competition_series", force: :cascade do |t|
    t.string   "title",      limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "competition_series_grades", force: :cascade do |t|
    t.integer  "competition_series_id", limit: 4, null: false
    t.integer  "grade_id",              limit: 4, null: false
    t.integer  "user_id",               limit: 4, null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "competition_series_grades", ["competition_series_id"], name: "index_competition_series_grades_on_competition_series_id", using: :btree
  add_index "competition_series_grades", ["grade_id"], name: "index_competition_series_grades_on_grade_id", using: :btree
  add_index "competition_series_grades", ["user_id"], name: "index_competition_series_grades_on_user_id", using: :btree

  create_table "competitions", force: :cascade do |t|
    t.string   "title",                limit: 255
    t.datetime "entries_open_at"
    t.datetime "entries_close_at"
    t.datetime "results_published_at"
    t.string   "judge_key",            limit: 255
    t.text     "notes",                limit: 65535
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "entry_limit",          limit: 4,     default: 0, null: false
  end

  create_table "delayed_jobs", force: :cascade do |t|
    t.integer  "priority",   limit: 4,     default: 0, null: false
    t.integer  "attempts",   limit: 4,     default: 0, null: false
    t.text     "handler",    limit: 65535,             null: false
    t.text     "last_error", limit: 65535
    t.datetime "run_at"
    t.datetime "locked_at"
    t.datetime "failed_at"
    t.string   "locked_by",  limit: 255
    t.string   "queue",      limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "delayed_jobs", ["priority", "run_at"], name: "delayed_jobs_priority", using: :btree

  create_table "entries", force: :cascade do |t|
    t.integer  "user_id",         limit: 4
    t.integer  "competition_id",  limit: 4
    t.integer  "section_id",      limit: 4
    t.integer  "rating_id",       limit: 4
    t.integer  "grade_id",        limit: 4
    t.string   "title",           limit: 255
    t.string   "photo",           limit: 255
    t.text     "notes",           limit: 65535
    t.integer  "order",           limit: 4,     null: false
    t.integer  "photo_file_size", limit: 4
    t.integer  "photo_width",     limit: 4
    t.integer  "photo_height",    limit: 4
    t.text     "exif",            limit: 65535
    t.datetime "created_at"
    t.datetime "updated_at"
    t.datetime "deleted_at"
  end

  add_index "entries", ["competition_id"], name: "index_entries_on_competition_id", using: :btree
  add_index "entries", ["deleted_at"], name: "index_entries_on_deleted_at", using: :btree
  add_index "entries", ["grade_id"], name: "index_entries_on_grade_id", using: :btree
  add_index "entries", ["order"], name: "index_entries_on_order", using: :btree
  add_index "entries", ["section_id"], name: "index_entries_on_section_id", using: :btree
  add_index "entries", ["user_id"], name: "index_entries_on_user_id", using: :btree

  create_table "grades", force: :cascade do |t|
    t.integer  "competition_series_id", limit: 4
    t.string   "title",                 limit: 255
    t.integer  "order",                 limit: 4,   default: 0, null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "grades", ["competition_series_id"], name: "index_grades_on_competition_series_id", using: :btree

  create_table "ratings", force: :cascade do |t|
    t.string   "title",               limit: 255
    t.integer  "points",              limit: 4,   default: 0, null: false
    t.integer  "max_per_grade",       limit: 4,   default: 0, null: false
    t.integer  "max_per_competition", limit: 4,   default: 0, null: false
    t.integer  "order",               limit: 4,   default: 0, null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "short",               limit: 255
  end

  create_table "sections", force: :cascade do |t|
    t.integer  "competition_series_id", limit: 4
    t.integer  "competition_id",        limit: 4
    t.string   "title",                 limit: 255
    t.integer  "entry_limit",           limit: 4
    t.integer  "max_height",            limit: 4
    t.integer  "max_width",             limit: 4
    t.integer  "max_file_size",         limit: 4
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "order",                 limit: 4,   default: 0, null: false
  end

  add_index "sections", ["competition_id", "order"], name: "index_sections_on_competition_id_and_order", unique: true, using: :btree
  add_index "sections", ["competition_id"], name: "index_sections_on_competition_id", using: :btree
  add_index "sections", ["competition_series_id"], name: "index_sections_on_competition_series_id", using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "email",                  limit: 255, default: "",    null: false
    t.string   "encrypted_password",     limit: 255, default: "",    null: false
    t.string   "reset_password_token",   limit: 255
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          limit: 4,   default: 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip",     limit: 255
    t.string   "last_sign_in_ip",        limit: 255
    t.string   "first_name",             limit: 255
    t.string   "last_name",              limit: 255
    t.boolean  "admin",                              default: false, null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

end
