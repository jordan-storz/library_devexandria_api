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

ActiveRecord::Schema.define(version: 20170316002110) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "books", force: :cascade do |t|
    t.string   "title"
    t.string   "content"
    t.string   "source_url"
    t.integer  "tag_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["tag_id"], name: "index_books_on_tag_id", using: :btree
  end

  create_table "books_libraries", id: false, force: :cascade do |t|
    t.integer "book_id",    null: false
    t.integer "library_id", null: false
  end

  create_table "books_tags", id: false, force: :cascade do |t|
    t.integer "tag_id",  null: false
    t.integer "book_id", null: false
  end

  create_table "events", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "book_id"
    t.integer  "library_id"
    t.string   "event_type"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["book_id"], name: "index_events_on_book_id", using: :btree
    t.index ["library_id"], name: "index_events_on_library_id", using: :btree
    t.index ["user_id"], name: "index_events_on_user_id", using: :btree
  end

  create_table "follows", force: :cascade do |t|
    t.integer  "follower_id"
    t.integer  "followee_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.index ["followee_id"], name: "index_follows_on_followee_id", using: :btree
    t.index ["follower_id"], name: "index_follows_on_follower_id", using: :btree
  end

  create_table "libraries", force: :cascade do |t|
    t.integer  "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_libraries_on_user_id", using: :btree
  end

  create_table "libraries_tags", id: false, force: :cascade do |t|
    t.integer "library_id", null: false
    t.integer "tag_id",     null: false
  end

  create_table "subscriptions", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "library_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["library_id"], name: "index_subscriptions_on_library_id", using: :btree
    t.index ["user_id"], name: "index_subscriptions_on_user_id", using: :btree
  end

  create_table "tags", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string   "username"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string   "provider"
    t.string   "uid"
  end

  add_foreign_key "books", "tags"
  add_foreign_key "events", "books"
  add_foreign_key "events", "libraries"
  add_foreign_key "events", "users"
  add_foreign_key "libraries", "users"
  add_foreign_key "subscriptions", "libraries"
  add_foreign_key "subscriptions", "users"
end
