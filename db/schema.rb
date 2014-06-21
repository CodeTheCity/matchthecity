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

ActiveRecord::Schema.define(version: 20140621134807) do

  create_table "activities", force: true do |t|
    t.string   "title"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "category"
  end

  create_table "candidates", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "candidates_skills", id: false, force: true do |t|
    t.integer "candidate_id"
    t.integer "skill_id"
  end

  add_index "candidates_skills", ["candidate_id", "skill_id"], name: "index_candidates_skills_on_candidate_id_and_skill_id", using: :btree

  create_table "opportunities", force: true do |t|
    t.string   "name"
    t.string   "category"
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "activity_id"
  end

  create_table "opportunities_skills", id: false, force: true do |t|
    t.integer "opportunity_id"
    t.integer "skill_id"
  end

  add_index "opportunities_skills", ["opportunity_id", "skill_id"], name: "index_opportunities_skills_on_opportunity_id_and_skill_id", using: :btree

  create_table "skills", force: true do |t|
    t.string   "title"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
