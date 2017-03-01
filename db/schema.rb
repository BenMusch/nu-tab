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

ActiveRecord::Schema.define(version: 20170227191302) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "check_ins", force: :cascade do |t|
    t.integer  "round_number"
    t.string   "subject_type"
    t.integer  "subject_id"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
    t.index ["subject_type", "subject_id"], name: "index_subjects", using: :btree
  end

  create_table "debater_round_stats", force: :cascade do |t|
    t.integer  "debater_id"
    t.integer  "round_id"
    t.float    "speaker"
    t.integer  "ranks"
    t.integer  "position"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["debater_id"], name: "index_debater_round_stats_on_debater_id", using: :btree
    t.index ["round_id"], name: "index_debater_round_stats_on_round_id", using: :btree
  end

  create_table "debater_teams", force: :cascade do |t|
    t.integer  "debater_id"
    t.integer  "team_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["debater_id"], name: "index_debater_teams_on_debater_id", using: :btree
    t.index ["team_id"], name: "index_debater_teams_on_team_id", using: :btree
  end

  create_table "debaters", force: :cascade do |t|
    t.string   "name"
    t.boolean  "novice"
    t.integer  "school_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["school_id"], name: "index_debaters_on_school_id", using: :btree
  end

  create_table "delayed_jobs", force: :cascade do |t|
    t.integer  "priority",   default: 0, null: false
    t.integer  "attempts",   default: 0, null: false
    t.text     "handler",                null: false
    t.text     "last_error"
    t.datetime "run_at"
    t.datetime "locked_at"
    t.datetime "failed_at"
    t.string   "locked_by"
    t.string   "queue"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["priority", "run_at"], name: "delayed_jobs_priority", using: :btree
  end

  create_table "judge_rounds", force: :cascade do |t|
    t.boolean  "chair"
    t.integer  "round_id"
    t.integer  "judge_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["judge_id"], name: "index_judge_rounds_on_judge_id", using: :btree
    t.index ["round_id"], name: "index_judge_rounds_on_round_id", using: :btree
  end

  create_table "judge_schools", force: :cascade do |t|
    t.integer  "judge_id"
    t.integer  "school_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["judge_id"], name: "index_judge_schools_on_judge_id", using: :btree
    t.index ["school_id"], name: "index_judge_schools_on_school_id", using: :btree
  end

  create_table "judges", force: :cascade do |t|
    t.string   "name"
    t.integer  "rank"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "protections", force: :cascade do |t|
    t.integer  "team_id"
    t.integer  "school_id"
    t.string   "type"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["school_id"], name: "index_protections_on_school_id", using: :btree
    t.index ["team_id"], name: "index_protections_on_team_id", using: :btree
  end

  create_table "rooms", force: :cascade do |t|
    t.string   "name"
    t.integer  "rank"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "rounds", force: :cascade do |t|
    t.integer  "result"
    t.integer  "room_id"
    t.integer  "gov_team_id"
    t.integer  "opp_team_id"
    t.integer  "round_number"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
    t.index ["gov_team_id"], name: "index_rounds_on_gov_team_id", using: :btree
    t.index ["opp_team_id"], name: "index_rounds_on_opp_team_id", using: :btree
    t.index ["room_id"], name: "index_rounds_on_room_id", using: :btree
  end

  create_table "schools", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "scratches", force: :cascade do |t|
    t.integer  "team_id"
    t.integer  "judge_id"
    t.integer  "type"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["judge_id"], name: "index_scratches_on_judge_id", using: :btree
    t.index ["team_id"], name: "index_scratches_on_team_id", using: :btree
  end

  create_table "teams", force: :cascade do |t|
    t.string   "name"
    t.integer  "seed"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "debater_teams", "debaters"
  add_foreign_key "debater_teams", "teams"
  add_foreign_key "debaters", "schools"
  add_foreign_key "judge_schools", "judges"
  add_foreign_key "judge_schools", "schools"
  add_foreign_key "protections", "schools"
  add_foreign_key "protections", "teams"
  add_foreign_key "scratches", "judges"
  add_foreign_key "scratches", "teams"
end
