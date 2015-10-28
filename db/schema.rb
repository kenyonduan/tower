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

ActiveRecord::Schema.define(version: 20151028145209) do

  create_table "accesses", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "resource_id"
    t.string   "resource_type"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
  end

  add_index "accesses", ["resource_type", "resource_id"], name: "index_accesses_on_resource_type_and_resource_id"
  add_index "accesses", ["user_id"], name: "index_accesses_on_user_id"

  create_table "calendar_events", force: :cascade do |t|
    t.string   "content"
    t.date     "begin"
    t.date     "end"
    t.date     "remind_time"
    t.text     "location"
    t.boolean  "is_show_creator"
    t.integer  "caleventable_id"
    t.string   "caleventable_type"
    t.datetime "created_at",        null: false
    t.datetime "updated_at",        null: false
  end

  add_index "calendar_events", ["caleventable_type", "caleventable_id"], name: "index_calendar_events_on_caleventable_type_and_caleventable_id"

  create_table "calendars", force: :cascade do |t|
    t.string   "name"
    t.integer  "creator_id"
    t.integer  "team_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "calendars", ["creator_id"], name: "index_calendars_on_creator_id"
  add_index "calendars", ["team_id"], name: "index_calendars_on_team_id"

  create_table "comments", force: :cascade do |t|
    t.text     "content"
    t.integer  "commentable_id"
    t.string   "commentable_type"
    t.integer  "event_id"
    t.integer  "creator_id"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
  end

  add_index "comments", ["commentable_type", "commentable_id"], name: "index_comments_on_commentable_type_and_commentable_id"
  add_index "comments", ["creator_id"], name: "index_comments_on_creator_id"
  add_index "comments", ["event_id"], name: "index_comments_on_event_id"

  create_table "events", force: :cascade do |t|
    t.text     "action"
    t.string   "type"
    t.integer  "initiator_id"
    t.integer  "target_id"
    t.string   "target_type"
    t.integer  "projectable_id"
    t.string   "projectable_type"
    t.text     "detail"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
  end

  add_index "events", ["initiator_id"], name: "index_events_on_initiator_id"
  add_index "events", ["projectable_type", "projectable_id"], name: "index_events_on_projectable_type_and_projectable_id"
  add_index "events", ["target_type", "target_id"], name: "index_events_on_target_type_and_target_id"

  create_table "memberships", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "team_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "memberships", ["team_id"], name: "index_memberships_on_team_id"
  add_index "memberships", ["user_id"], name: "index_memberships_on_user_id"

  create_table "projects", force: :cascade do |t|
    t.string   "name"
    t.integer  "team_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "projects", ["team_id"], name: "index_projects_on_team_id"

  create_table "teams", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "todos", force: :cascade do |t|
    t.string   "title"
    t.text     "description"
    t.date     "deadline"
    t.integer  "status",      default: 0
    t.integer  "project_id"
    t.integer  "creator_id"
    t.integer  "assignee_id"
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
  end

  add_index "todos", ["assignee_id"], name: "index_todos_on_assignee_id"
  add_index "todos", ["creator_id"], name: "index_todos_on_creator_id"
  add_index "todos", ["project_id"], name: "index_todos_on_project_id"

  create_table "users", force: :cascade do |t|
    t.string   "password_digest"
    t.string   "email"
    t.string   "name"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
  end

end
