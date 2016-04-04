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

ActiveRecord::Schema.define(version: 20160404114341) do

  create_table "absentees", force: :cascade do |t|
    t.integer  "student_id"
    t.integer  "attendance_registry_id"
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  add_index "absentees", ["attendance_registry_id"], name: "index_absentees_on_attendance_registry_id"
  add_index "absentees", ["student_id"], name: "index_absentees_on_student_id"

  create_table "attendance_registries", force: :cascade do |t|
    t.date     "date"
    t.integer  "section_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "attendance_registries", ["section_id"], name: "index_attendance_registries_on_section_id"

  create_table "exams", force: :cascade do |t|
    t.integer  "student_id"
    t.integer  "english"
    t.integer  "hindi"
    t.integer  "mathematics"
    t.integer  "science"
    t.integer  "social"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  add_index "exams", ["student_id"], name: "index_exams_on_student_id"

  create_table "houses", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "klasses", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "sections", force: :cascade do |t|
    t.string   "name"
    t.integer  "klass_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "sections", ["klass_id"], name: "index_sections_on_klass_id"

  create_table "students", force: :cascade do |t|
    t.integer  "section_id"
    t.string   "name"
    t.string   "fathers_name"
    t.integer  "gender"
    t.string   "email"
    t.date     "dob"
    t.string   "phone"
    t.text     "address"
    t.integer  "house_id"
    t.integer  "roll_number"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  add_index "students", ["house_id"], name: "index_students_on_house_id"
  add_index "students", ["section_id"], name: "index_students_on_section_id"

end
