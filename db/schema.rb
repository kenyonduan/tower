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

ActiveRecord::Schema.define(version: 20151027055125) do

  create_table "accesses", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "project_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "accesses", ["project_id"], name: "index_accesses_on_project_id"
  add_index "accesses", ["user_id"], name: "index_accesses_on_user_id"

  create_table "comments", force: :cascade do |t|
    t.text     "content"
    t.integer  "commentable_id"
    t.string   "commentable_type"
    t.integer  "event_id"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
  end

  add_index "comments", ["commentable_type", "commentable_id"], name: "index_comments_on_commentable_type_and_commentable_id"
  add_index "comments", ["event_id"], name: "index_comments_on_event_id"

  create_table "events", force: :cascade do |t|
    t.string   "action"
    t.string   "type"
    t.integer  "initiator_id"
    t.integer  "target_id"
    t.string   "target_type"
    t.integer  "projectable_id"
    t.string   "projectable_type"
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