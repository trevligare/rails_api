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

ActiveRecord::Schema.define(version: 2018_07_04_212409) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "classifications", force: :cascade do |t|
    t.bigint "label_id"
    t.bigint "reporter_id"
    t.bigint "statement_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["label_id"], name: "index_classifications_on_label_id"
    t.index ["reporter_id"], name: "index_classifications_on_reporter_id"
    t.index ["statement_id"], name: "index_classifications_on_statement_id"
  end

  create_table "labels", force: :cascade do |t|
    t.string "name"
    t.string "slug"
    t.boolean "nice"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "reporters", force: :cascade do |t|
    t.string "uuid"
    t.bigint "source_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["source_id"], name: "index_reporters_on_source_id"
  end

  create_table "sources", force: :cascade do |t|
    t.string "name"
    t.string "token"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "statements", force: :cascade do |t|
    t.string "text"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "reporter_id"
    t.index ["reporter_id"], name: "index_statements_on_reporter_id"
  end

  add_foreign_key "classifications", "labels"
  add_foreign_key "classifications", "reporters"
  add_foreign_key "classifications", "statements"
  add_foreign_key "reporters", "sources"
  add_foreign_key "statements", "reporters"
end
