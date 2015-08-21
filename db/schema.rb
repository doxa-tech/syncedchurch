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

ActiveRecord::Schema.define(version: 20150821100019) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "families", force: :cascade do |t|
    t.string   "lastname"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "groups", force: :cascade do |t|
    t.string   "name"
    t.integer  "group_type"
    t.integer  "place"
    t.string   "place_other"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
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
    t.integer  "gender"
    t.integer  "family_id"
    t.integer  "role"
  end

  add_index "members", ["family_id"], name: "index_members_on_family_id", using: :btree

  create_table "phones", force: :cascade do |t|
    t.string   "number"
    t.integer  "member_id"
    t.integer  "phone_type"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean  "private"
  end

  add_index "phones", ["member_id"], name: "index_phones_on_member_id", using: :btree

  add_foreign_key "members", "families"
  add_foreign_key "phones", "members"
end
