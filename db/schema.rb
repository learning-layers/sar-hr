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

ActiveRecord::Schema.define(version: 20150522081202) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "sessions", force: :cascade do |t|
    t.integer  "user_id",    null: false
    t.string   "token",      null: false
    t.datetime "expires_on"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "sessions", ["token"], name: "index_sessions_on_token", using: :btree
  add_index "sessions", ["user_id"], name: "index_sessions_on_user_id", using: :btree

  create_table "skills", force: :cascade do |t|
    t.string   "name",       null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "skills_users", id: false, force: :cascade do |t|
    t.integer "skill_id", null: false
    t.integer "user_id",  null: false
  end

  add_index "skills_users", ["skill_id", "user_id"], name: "index_skills_users_on_skill_id_and_user_id", unique: true, using: :btree
  add_index "skills_users", ["user_id", "skill_id"], name: "index_skills_users_on_user_id_and_skill_id", unique: true, using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "email",                          null: false
    t.string   "encrypted_password",             null: false
    t.string   "first_name",                     null: false
    t.string   "last_name",                      null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "role",               default: 0, null: false
    t.integer  "status",             default: 0, null: false
    t.string   "title"
    t.string   "peer_id"
  end

  add_index "users", ["email"], name: "index_users_on_email", using: :btree

end
