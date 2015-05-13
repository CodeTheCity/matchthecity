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

ActiveRecord::Schema.define(version: 20150511073032) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "activities", force: true do |t|
    t.string   "title"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "category"
  end

  create_table "admins", force: true do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "admins", ["email"], name: "index_admins_on_email", unique: true, using: :btree
  add_index "admins", ["reset_password_token"], name: "index_admins_on_reset_password_token", unique: true, using: :btree

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

  create_table "effort_ratings", force: true do |t|
    t.integer  "rating"
    t.integer  "opportunity_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "effort_ratings", ["opportunity_id"], name: "index_effort_ratings_on_opportunity_id", using: :btree

  create_table "opportunities", force: true do |t|
    t.string   "name"
    t.string   "category"
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "activity_id"
    t.integer  "sub_activity_id"
    t.integer  "venue_id"
    t.string   "room"
    t.string   "start_time"
    t.string   "end_time"
    t.string   "day_of_week"
    t.string   "image_url"
    t.string   "source_reference"
    t.integer  "effort_rating",    default: 0
    t.integer  "organisation_id"
    t.integer  "week_day"
  end

  add_index "opportunities", ["organisation_id"], name: "index_opportunities_on_organisation_id", using: :btree
  add_index "opportunities", ["sub_activity_id"], name: "index_opportunities_on_sub_activity_id", using: :btree
  add_index "opportunities", ["venue_id"], name: "index_opportunities_on_venue_id", using: :btree

  create_table "opportunities_skills", id: false, force: true do |t|
    t.integer "opportunity_id"
    t.integer "skill_id"
  end

  add_index "opportunities_skills", ["opportunity_id", "skill_id"], name: "index_opportunities_skills_on_opportunity_id_and_skill_id", using: :btree

  create_table "organisations", force: true do |t|
    t.string   "name"
    t.string   "address"
    t.string   "postcode"
    t.string   "latitude"
    t.string   "longitude"
    t.string   "email"
    t.string   "telephone"
    t.string   "web"
    t.integer  "region_id"
    t.string   "logo_url"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "organisations", ["region_id"], name: "index_organisations_on_region_id", using: :btree

  create_table "organisations_users", id: false, force: true do |t|
    t.integer "organisation_id"
    t.integer "user_id"
  end

  add_index "organisations_users", ["organisation_id", "user_id"], name: "org_user_index", using: :btree
  add_index "organisations_users", ["user_id", "organisation_id"], name: "user_org_index", using: :btree

  create_table "regions", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "skills", force: true do |t|
    t.string   "title"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "sub_activities", force: true do |t|
    t.integer  "activity_id"
    t.string   "title"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "sub_activities", ["activity_id"], name: "index_sub_activities_on_activity_id", using: :btree

  create_table "taggings", force: true do |t|
    t.integer  "tag_id"
    t.integer  "taggable_id"
    t.string   "taggable_type"
    t.integer  "tagger_id"
    t.string   "tagger_type"
    t.string   "context",       limit: 128
    t.datetime "created_at"
  end

  add_index "taggings", ["tag_id", "taggable_id", "taggable_type", "context", "tagger_id", "tagger_type"], name: "taggings_idx", unique: true, using: :btree
  add_index "taggings", ["taggable_id", "taggable_type", "context"], name: "index_taggings_on_taggable_id_and_taggable_type_and_context", using: :btree

  create_table "tags", force: true do |t|
    t.string  "name"
    t.integer "taggings_count", default: 0
  end

  add_index "tags", ["name"], name: "index_tags_on_name", unique: true, using: :btree

  create_table "users", force: true do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "unconfirmed_email"
    t.integer  "failed_attempts",        default: 0,  null: false
    t.string   "unlock_token"
    t.datetime "locked_at"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "name"
  end

  add_index "users", ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true, using: :btree
  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
  add_index "users", ["unlock_token"], name: "index_users_on_unlock_token", unique: true, using: :btree

  create_table "venue_notices", force: true do |t|
    t.integer  "venue_id"
    t.datetime "starts"
    t.datetime "expires"
    t.text     "message"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "venue_notices", ["venue_id"], name: "index_venue_notices_on_venue_id", using: :btree

  create_table "venue_owners", force: true do |t|
    t.string   "name"
    t.string   "address"
    t.string   "postcode"
    t.string   "latitude"
    t.string   "longitude"
    t.string   "email"
    t.string   "telephone"
    t.string   "web"
    t.integer  "region_id"
    t.string   "logo_url"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "slug"
  end

  add_index "venue_owners", ["region_id"], name: "index_venue_owners_on_region_id", using: :btree

  create_table "venues", force: true do |t|
    t.string   "name"
    t.string   "address"
    t.string   "postcode"
    t.string   "latitude"
    t.string   "longitude"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "email"
    t.string   "telephone"
    t.string   "web"
    t.integer  "region_id"
    t.string   "source_reference"
    t.string   "logo_url"
    t.integer  "venue_owner_id"
    t.string   "slug"
    t.text     "description"
  end

  add_index "venues", ["region_id"], name: "index_venues_on_region_id", using: :btree
  add_index "venues", ["venue_owner_id"], name: "index_venues_on_venue_owner_id", using: :btree

end
