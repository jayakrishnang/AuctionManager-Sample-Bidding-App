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

ActiveRecord::Schema.define(version: 20170329215429) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "admins", force: :cascade do |t|
    t.string "name"
    t.integer "admin_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string "current_sign_in_ip"
    t.string "last_sign_in_ip"
    t.index ["email"], name: "index_admins_on_email", unique: true
    t.index ["reset_password_token"], name: "index_admins_on_reset_password_token", unique: true
  end

  create_table "balls", force: :cascade do |t|
    t.integer "over_id"
    t.integer "batsman_id"
    t.integer "runs_scored"
    t.string "result"
    t.integer "extra"
    t.string "extra_type"
    t.integer "wicket_id"
    t.boolean "is_legitimate"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "bid_logs", force: :cascade do |t|
    t.integer "amount"
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "player_id"
    t.boolean "is_closed"
    t.index ["user_id"], name: "index_bid_logs_on_user_id"
  end

  create_table "designations", force: :cascade do |t|
    t.string "designation_name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "innings", force: :cascade do |t|
    t.integer "team_id"
    t.integer "match_id"
    t.integer "runs_scored"
    t.decimal "overs_played", precision: 10, scale: 1
    t.string "status"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "opponent_id"
  end

  create_table "matches", force: :cascade do |t|
    t.string "name"
    t.integer "team_1_id"
    t.integer "team_2_id"
    t.integer "toss_winner_id"
    t.integer "winner_id"
    t.string "status"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "overs", force: :cascade do |t|
    t.integer "bowler_id"
    t.integer "inning_id"
    t.integer "over_number"
    t.integer "runs_scored"
    t.string "status"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "roles", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "teams", force: :cascade do |t|
    t.string "name"
    t.integer "purse_spent"
    t.integer "total_purse"
    t.integer "owner_id"
  end

  create_table "users", force: :cascade do |t|
    t.bigint "designation_id"
    t.string "first_name"
    t.string "middle_name"
    t.string "last_name"
    t.string "email"
    t.string "login_id"
    t.string "employee_id"
    t.date "date_of_birth"
    t.string "gender"
    t.string "time_zone"
    t.date "date_of_joining"
    t.text "education"
    t.text "comments"
    t.boolean "is_locked"
    t.date "deactivated_on"
    t.text "reason"
    t.string "work_phone"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string "current_sign_in_ip"
    t.string "last_sign_in_ip"
    t.bigint "role_id"
    t.float "previous_experience"
    t.integer "failed_attempts", default: 0
    t.string "unlock_token"
    t.datetime "locked_at"
    t.string "avatar"
    t.string "status"
    t.integer "base_points"
    t.integer "sold_points"
    t.integer "team_id"
    t.string "team_status"
    t.boolean "is_bowling"
    t.boolean "is_batting"
    t.boolean "is_on_strike", default: false
    t.index ["designation_id"], name: "index_users_on_designation_id"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
    t.index ["role_id"], name: "index_users_on_role_id"
  end

  create_table "wickets", force: :cascade do |t|
    t.integer "batsman_id"
    t.integer "bowler_id"
    t.integer "ball_id"
    t.integer "inning_id"
    t.string "wicket_type"
    t.integer "wicket_partner_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "bid_logs", "users"
  add_foreign_key "users", "roles"
end
