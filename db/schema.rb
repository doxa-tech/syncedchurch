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

ActiveRecord::Schema.define(version: 20151031230450) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "adeia_action_permissions", force: :cascade do |t|
    t.integer  "adeia_action_id"
    t.integer  "adeia_permission_id"
    t.datetime "created_at",          null: false
    t.datetime "updated_at",          null: false
  end

  add_index "adeia_action_permissions", ["adeia_action_id"], name: "index_adeia_action_permissions_on_adeia_action_id", using: :btree
  add_index "adeia_action_permissions", ["adeia_permission_id"], name: "index_adeia_action_permissions_on_adeia_permission_id", using: :btree

  create_table "adeia_actions", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "adeia_elements", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "adeia_group_users", force: :cascade do |t|
    t.integer  "adeia_group_id"
    t.integer  "user_id"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
  end

  add_index "adeia_group_users", ["adeia_group_id"], name: "index_adeia_group_users_on_adeia_group_id", using: :btree
  add_index "adeia_group_users", ["user_id"], name: "index_adeia_group_users_on_user_id", using: :btree

  create_table "adeia_groups", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "adeia_permissions", force: :cascade do |t|
    t.integer  "owner_id"
    t.string   "owner_type"
    t.integer  "adeia_element_id"
    t.integer  "permission_type"
    t.boolean  "read_right",       default: false
    t.boolean  "create_right",     default: false
    t.boolean  "update_right",     default: false
    t.boolean  "destroy_right",    default: false
    t.integer  "resource_id"
    t.datetime "created_at",                       null: false
    t.datetime "updated_at",                       null: false
  end

  add_index "adeia_permissions", ["adeia_element_id"], name: "index_adeia_permissions_on_adeia_element_id", using: :btree
  add_index "adeia_permissions", ["owner_type", "owner_id"], name: "index_adeia_permissions_on_owner_type_and_owner_id", using: :btree

  create_table "adeia_tokens", force: :cascade do |t|
    t.string   "token"
    t.boolean  "is_valid"
    t.integer  "adeia_permission_id"
    t.date     "exp_at"
    t.datetime "created_at",          null: false
    t.datetime "updated_at",          null: false
  end

  add_index "adeia_tokens", ["adeia_permission_id"], name: "index_adeia_tokens_on_adeia_permission_id", using: :btree

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

  create_table "meeting_files", force: :cascade do |t|
    t.string   "name"
    t.string   "file"
    t.string   "extension"
    t.integer  "size"
    t.integer  "meeting_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "meeting_files", ["meeting_id"], name: "index_meeting_files_on_meeting_id", using: :btree

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

  create_table "users", force: :cascade do |t|
    t.string   "password_digest"
    t.string   "reset_token"
    t.string   "reset_send_at"
    t.string   "remember_token"
    t.boolean  "confirmed",       default: false
    t.integer  "member_id"
    t.datetime "created_at",                      null: false
    t.datetime "updated_at",                      null: false
  end

  add_index "users", ["member_id"], name: "index_users_on_member_id", using: :btree

  add_foreign_key "adeia_action_permissions", "adeia_actions"
  add_foreign_key "adeia_action_permissions", "adeia_permissions"
  add_foreign_key "adeia_group_users", "adeia_groups"
  add_foreign_key "adeia_group_users", "users"
  add_foreign_key "adeia_permissions", "adeia_elements"
  add_foreign_key "adeia_tokens", "adeia_permissions"
  add_foreign_key "attending_meeting_members", "meetings"
  add_foreign_key "attending_meeting_members", "members"
  add_foreign_key "external_meeting_members", "meetings"
  add_foreign_key "external_meeting_members", "members"
  add_foreign_key "followups", "members"
  add_foreign_key "followups", "members", name: "fk_counselors_followups"
  add_foreign_key "group_members", "groups"
  add_foreign_key "group_members", "members"
  add_foreign_key "meeting_files", "meetings"
  add_foreign_key "meetings", "groups"
  add_foreign_key "members", "families"
  add_foreign_key "phones", "members"
  add_foreign_key "users", "members"
end
