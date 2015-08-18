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

ActiveRecord::Schema.define(version: 20150604180927) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "genders", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "members", force: :cascade do |t|
    t.string   "firstname"
    t.string   "lastname"
    t.date     "birthday"
    t.string   "job"
    t.string   "adress"
    t.integer  "npa"
    t.string   "city"
    t.string   "email"
    t.string   "private",    default: [],              array: true
    t.text     "extra"
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
    t.integer  "gender_id"
  end

  add_index "members", ["gender_id"], name: "index_members_on_gender_id", using: :btree

  create_table "phone_types", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "phones", force: :cascade do |t|
    t.string   "number"
    t.integer  "member_id"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
    t.integer  "phone_type_id"
  end

  add_index "phones", ["member_id"], name: "index_phones_on_member_id", using: :btree
  add_index "phones", ["phone_type_id"], name: "index_phones_on_phone_type_id", using: :btree

  add_foreign_key "members", "genders"
  add_foreign_key "phones", "members"
  add_foreign_key "phones", "phone_types"
end
