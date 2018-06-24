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

ActiveRecord::Schema.define(version: 20180624175116) do

  create_table "carriers", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci" do |t|
    t.string   "name"
    t.string   "url"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "clients", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci" do |t|
    t.string   "name"
    t.string   "street"
    t.string   "postal_code"
    t.string   "city"
    t.datetime "created_at",        null: false
    t.datetime "updated_at",        null: false
    t.string   "adress_complement"
    t.boolean  "disable"
  end

  create_table "contacts", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci" do |t|
    t.string   "last_name"
    t.string   "first_name"
    t.string   "phone_nbr"
    t.string   "email"
    t.integer  "client_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["client_id"], name: "fk_rails_766917a6b6", using: :btree
  end

  create_table "events", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci" do |t|
    t.integer  "user_id"
    t.string   "title"
    t.text     "details",    limit: 65535
    t.datetime "time_begin"
    t.datetime "time_end"
    t.datetime "created_at",                               null: false
    t.datetime "updated_at",                               null: false
    t.boolean  "private",                  default: false
    t.index ["user_id"], name: "index_events_on_user_id", using: :btree
  end

  create_table "feedbacks", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci" do |t|
    t.text     "description", limit: 65535
    t.integer  "project_id"
    t.integer  "worker_id"
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
    t.index ["project_id"], name: "fk_rails_8f27045d07", using: :btree
    t.index ["worker_id"], name: "fk_rails_2cb4658f09", using: :btree
  end

  create_table "papers", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci" do |t|
    t.integer "paper"
    t.integer "density"
    t.integer "shape",                    default: 0
    t.integer "project_id"
    t.text    "note",       limit: 65535
    t.index ["project_id"], name: "fk_rails_c9a368db3b", using: :btree
  end

  create_table "paperstock_items", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "name"
    t.integer  "thirtytwofortyfive"
    t.integer  "fiftytwoseventytwo"
    t.integer  "paperstock_id"
    t.integer  "toorder"
    t.datetime "created_at",         null: false
    t.datetime "updated_at",         null: false
    t.index ["paperstock_id"], name: "fk_rails_480399c371", using: :btree
  end

  create_table "paperstocks", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "participants", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci" do |t|
    t.integer  "project_id"
    t.integer  "contact_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["contact_id"], name: "index_participants_on_contact_id", using: :btree
    t.index ["project_id"], name: "index_participants_on_project_id", using: :btree
  end

  create_table "projects", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci" do |t|
    t.string   "name"
    t.string   "number"
    t.integer  "owner_id"
    t.integer  "worker_id"
    t.datetime "created_at",                                     null: false
    t.datetime "updated_at",                                     null: false
    t.integer  "project_type"
    t.text     "description",      limit: 65535
    t.date     "first_feedback"
    t.date     "delivery_date"
    t.date     "good_to_print"
    t.integer  "feedback_number",                default: 3
    t.integer  "contact_id"
    t.integer  "priority",                       default: 0
    t.boolean  "archived",                       default: false
    t.integer  "state",                          default: 0
    t.text     "important",        limit: 65535
    t.integer  "progression",                    default: 0
    t.integer  "estimated_time",                 default: 0
    t.date     "departure_date"
    t.integer  "test_print",                     default: 0
    t.integer  "colors"
    t.boolean  "various_input",                  default: false
    t.string   "good_sheets_qty",                default: "0"
    t.string   "finished_doc_qty",               default: "0"
    t.boolean  "let_raw",                        default: false
    t.integer  "open_shape"
    t.integer  "finished_shape"
    t.integer  "filming"
    t.integer  "shaping"
    t.integer  "package"
    t.integer  "delivery"
    t.text     "notice",           limit: 65535
    t.string   "outsourcing"
    t.string   "special_shape"
    t.string   "diverse_shape"
    t.string   "photo_credit"
    t.string   "photo_price"
    t.string   "paper_gtp"
    t.string   "send_gtp"
    t.boolean  "create_email"
    t.integer  "carrier_id"
    t.string   "tracking_nbr"
    t.integer  "package_nbr"
    t.boolean  "tracking_email"
    t.string   "delivery_address"
    t.text     "note",             limit: 65535
    t.text     "secret_note",      limit: 65535
    t.integer  "orientation"
    t.index ["contact_id"], name: "fk_rails_d2ed3a7e49", using: :btree
    t.index ["owner_id"], name: "fk_rails_219ef9bf7d", using: :btree
    t.index ["worker_id"], name: "fk_rails_e1871a26bc", using: :btree
  end

  create_table "roles", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci" do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "tasks", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci" do |t|
    t.integer  "duration"
    t.integer  "project_id"
    t.integer  "worker_id"
    t.text     "description", limit: 65535
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
    t.index ["project_id"], name: "fk_rails_02e851e3b7", using: :btree
    t.index ["worker_id"], name: "fk_rails_5b266ced74", using: :btree
  end

  create_table "users", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci" do |t|
    t.string   "login"
    t.datetime "created_at",          null: false
    t.datetime "updated_at",          null: false
    t.string   "password_digest"
    t.string   "remember_digest"
    t.integer  "profile"
    t.string   "avatar_file_name"
    t.string   "avatar_content_type"
    t.integer  "avatar_file_size"
    t.datetime "avatar_updated_at"
  end

  create_table "various_stock_items", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "name"
    t.integer  "quantity"
    t.integer  "various_stock_id"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
    t.index ["various_stock_id"], name: "fk_rails_ef7ed46b3b", using: :btree
  end

  create_table "various_stocks", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "name"
    t.string   "color",      default: "#FFFFFF"
    t.datetime "created_at",                     null: false
    t.datetime "updated_at",                     null: false
  end

  add_foreign_key "contacts", "clients", on_delete: :nullify
  add_foreign_key "events", "users"
  add_foreign_key "feedbacks", "projects", on_delete: :nullify
  add_foreign_key "feedbacks", "users", column: "worker_id", on_delete: :nullify
  add_foreign_key "papers", "projects", on_delete: :nullify
  add_foreign_key "paperstock_items", "paperstocks", on_delete: :nullify
  add_foreign_key "projects", "users", column: "owner_id", on_delete: :nullify
  add_foreign_key "projects", "users", column: "worker_id", on_delete: :nullify
  add_foreign_key "tasks", "projects", on_delete: :nullify
  add_foreign_key "tasks", "users", column: "worker_id", on_delete: :nullify
  add_foreign_key "various_stock_items", "various_stocks", on_delete: :nullify
end
