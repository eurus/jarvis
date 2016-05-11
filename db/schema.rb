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

ActiveRecord::Schema.define(version: 20160407011116) do

  create_table "articals", force: :cascade do |t|
    t.string   "title",      limit: 255
    t.text     "content",    limit: 65535
    t.integer  "user_id",    limit: 4
    t.string   "origin",     limit: 255
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
  end

  create_table "bug_hunters", force: :cascade do |t|
    t.string   "project_name", limit: 255
    t.text     "trace",        limit: 65535
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
  end

  create_table "errands", force: :cascade do |t|
    t.string   "location",            limit: 255
    t.string   "content",             limit: 255
    t.date     "start_at"
    t.date     "end_at"
    t.integer  "project_id",          limit: 4
    t.integer  "user_id",             limit: 4
    t.float    "fee",                 limit: 24
    t.boolean  "approve",                         default: false
    t.boolean  "issue",                           default: false
    t.datetime "created_at",                                      null: false
    t.datetime "updated_at",                                      null: false
    t.date     "approve_time"
    t.date     "issue_time"
    t.string   "approve_by_username", limit: 255
    t.string   "issue_by_username",   limit: 255
  end

  create_table "feedbacks", force: :cascade do |t|
    t.integer  "user_id",    limit: 4
    t.text     "content",    limit: 65535
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
  end

  create_table "groups", force: :cascade do |t|
    t.integer  "leader",     limit: 4
    t.string   "name",       limit: 255
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
    t.text     "id_array",   limit: 65535
  end

  create_table "overtimes", force: :cascade do |t|
    t.date     "start_at"
    t.float    "duration",            limit: 24
    t.string   "content",             limit: 255
    t.integer  "user_id",             limit: 4
    t.boolean  "approve",                         default: false
    t.boolean  "issue",                           default: false
    t.integer  "project_id",          limit: 4
    t.datetime "created_at",                                      null: false
    t.datetime "updated_at",                                      null: false
    t.date     "approve_time"
    t.date     "issue_time"
    t.string   "approve_by_username", limit: 255
    t.string   "issue_by_username",   limit: 255
  end

  create_table "plans", force: :cascade do |t|
    t.string   "title",       limit: 255
    t.text     "description", limit: 65535
    t.integer  "user_id",     limit: 4
    t.string   "status",      limit: 255,   default: "未开始"
    t.string   "cut",         limit: 255
    t.date     "start_at"
    t.date     "end_at"
    t.datetime "created_at",                                null: false
    t.datetime "updated_at",                                null: false
    t.boolean  "done",                      default: false
    t.date     "done_at"
    t.integer  "creator_id",  limit: 4
  end

  create_table "project_logs", force: :cascade do |t|
    t.date     "date"
    t.string   "category",   limit: 255
    t.text     "content",    limit: 65535
    t.integer  "project_id", limit: 4
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
    t.integer  "user_id",    limit: 4
  end

  add_index "project_logs", ["project_id"], name: "index_project_logs_on_project_id", using: :btree
  add_index "project_logs", ["user_id"], name: "index_project_logs_on_user_id", using: :btree

  create_table "projects", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.string   "content",    limit: 255
    t.integer  "owner_id",   limit: 4
    t.string   "status",     limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
    t.date     "done_at"
  end

  create_table "projects_users", id: false, force: :cascade do |t|
    t.integer "project_id", limit: 4
    t.integer "user_id",    limit: 4
  end

  create_table "simple_captcha_data", force: :cascade do |t|
    t.string   "key",        limit: 40
    t.string   "value",      limit: 6
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "simple_captcha_data", ["key"], name: "idx_key", using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "email",                  limit: 255, default: "",       null: false
    t.string   "encrypted_password",     limit: 255, default: "",       null: false
    t.string   "reset_password_token",   limit: 255
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          limit: 4,   default: 0,        null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip",     limit: 255
    t.string   "last_sign_in_ip",        limit: 255
    t.datetime "created_at",                                            null: false
    t.datetime "updated_at",                                            null: false
    t.string   "username",               limit: 255
    t.string   "nickname",               limit: 255
    t.date     "join_at"
    t.date     "leave_at"
    t.string   "avatar",                 limit: 255
    t.string   "user_number",            limit: 255
    t.string   "realname",               limit: 255
    t.string   "gender",                 limit: 255
    t.integer  "supervisor_id",          limit: 4
    t.string   "role",                   limit: 255, default: "intern"
    t.date     "birthday"
    t.string   "idcode",                 limit: 255
    t.string   "constellation",          limit: 255
    t.string   "rank",                   limit: 255
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

  create_table "vacations", force: :cascade do |t|
    t.date     "start_at"
    t.float    "duration",            limit: 24
    t.string   "content",             limit: 255
    t.datetime "created_at",                                      null: false
    t.datetime "updated_at",                                      null: false
    t.integer  "user_id",             limit: 4
    t.boolean  "approve",                         default: false
    t.string   "cut",                 limit: 255
    t.date     "approve_time"
    t.date     "issue_time"
    t.string   "approve_by_username", limit: 255
  end

  create_table "weeklies", force: :cascade do |t|
    t.integer  "user_id",    limit: 4
    t.text     "sumary",     limit: 65535
    t.text     "hope",       limit: 65535
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
  end

  add_foreign_key "project_logs", "projects"
  add_foreign_key "project_logs", "users"
end
