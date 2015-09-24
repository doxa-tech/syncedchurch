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

ActiveRecord::Schema.define(version: 20150924153159) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "attending_meeting_members", force: :cascade do |t|
    t.integer  "meeting_id"
    t.integer  "member_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "attending_meeting_members", ["meeting_id"], name: "index_attending_meeting_members_on_meeting_id", using: :btree
  add_index "attending_meeting_members", ["member_id"], name: "index_attending_meeting_members_on_member_id", using: :btree

  create_table "external_meeting_members", force: :cascade do |t|
    t.integer  "meeting_id"
    t.integer  "member_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "external_meeting_members", ["meeting_id"], name: "index_external_meeting_members_on_meeting_id", using: :btree
  add_index "external_meeting_members", ["member_id"], name: "index_external_meeting_members_on_member_id", using: :btree

  create_table "families", force: :cascade do |t|
    t.string   "lastname"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "followups", force: :cascade do |t|
    t.integer  "member_id"
    t.integer  "counselor_id"
    t.date     "date"
    t.integer  "duration"
    t.text     "notes"
    t.integer  "place"
    t.integer  "reason"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  add_index "followups", ["counselor_id"], name: "index_followups_on_counselor_id", using: :btree
  add_index "followups", ["member_id"], name: "index_followups_on_member_id", using: :btree

  create_table "group_members", force: :cascade do |t|
    t.integer  "group_id"
    t.integer  "member_id"
    t.integer  "status",     default: 0
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  add_index "group_members", ["group_id"], name: "index_group_members_on_group_id", using: :btree
  add_index "group_members", ["member_id"], name: "index_group_members_on_member_id", using: :btree

  create_table "groups", force: :cascade do |t|
    t.string   "name"
    t.integer  "group_type"
    t.integer  "place"
    t.string   "place_other"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "meetings", force: :cascade do |t|
    t.date     "date"
    t.integer  "group_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "meetings", ["group_id"], name: "index_meetings_on_group_id", using: :btree

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

  add_foreign_key "attending_meeting_members", "meetings"
  add_foreign_key "attending_meeting_members", "members"
  add_foreign_key "external_meeting_members", "meetings"
  add_foreign_key "external_meeting_members", "members"
  add_foreign_key "followups", "members"
  add_foreign_key "followups", "members", name: "fk_counselors_followups"
  add_foreign_key "group_members", "groups"
  add_foreign_key "group_members", "members"
  add_foreign_key "meetings", "groups"
  add_foreign_key "members", "families"
  add_foreign_key "phones", "members"
end
