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

ActiveRecord::Schema.define(version: 20180211073911) do

  create_table "sample_requests", force: :cascade do |t|
    t.string "code"
    t.string "status"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "sample_types", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "sample_types_test_types", id: false, force: :cascade do |t|
    t.integer "sample_type_id"
    t.integer "test_type_id"
    t.index ["sample_type_id", "test_type_id"], name: "my_index", unique: true
  end

  create_table "samples", force: :cascade do |t|
    t.string "name"
    t.integer "qty"
    t.integer "sample_request_id"
    t.integer "test_type_id"
    t.integer "sample_type_id"
    t.integer "unit_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["sample_request_id"], name: "index_samples_on_sample_request_id"
    t.index ["sample_type_id"], name: "index_samples_on_sample_type_id"
    t.index ["test_type_id"], name: "index_samples_on_test_type_id"
    t.index ["unit_id"], name: "index_samples_on_unit_id"
  end

  create_table "test_types", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "units", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
