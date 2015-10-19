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

ActiveRecord::Schema.define(version: 20151019131740) do

  create_table "clients", force: :cascade do |t|
    t.string   "name",        limit: 255
    t.string   "street",      limit: 255
    t.string   "postal_code", limit: 255
    t.string   "town",        limit: 255
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
  end

  create_table "contacts", force: :cascade do |t|
    t.string   "last_name",  limit: 255
    t.string   "first_name", limit: 255
    t.string   "phone_nbr",  limit: 255
    t.string   "email",      limit: 255
    t.integer  "client_id",  limit: 4
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  add_index "contacts", ["client_id"], name: "fk_rails_766917a6b6", using: :btree

  create_table "projects", force: :cascade do |t|
    t.string   "name",            limit: 255
    t.string   "number",          limit: 255
    t.integer  "owner_id",        limit: 4
    t.integer  "worker_id",       limit: 4
    t.datetime "created_at",                                    null: false
    t.datetime "updated_at",                                    null: false
    t.string   "project_type",    limit: 255
    t.text     "description",     limit: 65535
    t.date     "first_feedback"
    t.date     "validation_date"
    t.date     "good_to_print"
    t.integer  "feedback_number", limit: 4
    t.integer  "contact_id",      limit: 4
    t.integer  "priority",        limit: 4,     default: 0
    t.boolean  "archived",                      default: false
    t.integer  "state",           limit: 4,     default: 0
  end

  add_index "projects", ["contact_id"], name: "fk_rails_d2ed3a7e49", using: :btree
  add_index "projects", ["owner_id"], name: "fk_rails_219ef9bf7d", using: :btree
  add_index "projects", ["worker_id"], name: "fk_rails_e1871a26bc", using: :btree

  create_table "roles", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "users", force: :cascade do |t|
    t.string   "login",               limit: 255
    t.datetime "created_at",                      null: false
    t.datetime "updated_at",                      null: false
    t.string   "password_digest",     limit: 255
    t.string   "remember_digest",     limit: 255
    t.integer  "profile",             limit: 4
    t.string   "avatar_file_name",    limit: 255
    t.string   "avatar_content_type", limit: 255
    t.integer  "avatar_file_size",    limit: 4
    t.datetime "avatar_updated_at"
  end

  add_foreign_key "contacts", "clients", on_delete: :nullify
  add_foreign_key "projects", "contacts", on_delete: :nullify
  add_foreign_key "projects", "users", column: "owner_id", on_delete: :nullify
  add_foreign_key "projects", "users", column: "worker_id", on_delete: :nullify
end
