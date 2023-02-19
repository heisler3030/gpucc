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

ActiveRecord::Schema.define(version: 2014_06_12_055738) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "applicants", id: :serial, force: :cascade do |t|
    t.string "email"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "challenge_assignments", id: :serial, force: :cascade do |t|
    t.integer "user_id"
    t.integer "challenge_id"
    t.date "join_date"
    t.date "completed_date"
    t.date "disqualify_date"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.date "last_notified"
    t.index ["challenge_id"], name: "index_challenge_assignments_on_challenge_id"
    t.index ["user_id"], name: "index_challenge_assignments_on_user_id"
  end

  create_table "challenges", id: :serial, force: :cascade do |t|
    t.string "title"
    t.text "description"
    t.date "start_date"
    t.date "end_date"
    t.integer "owner_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer "max_misses"
    t.date "join_by"
  end

  create_table "comments", id: :serial, force: :cascade do |t|
    t.integer "user_id"
    t.integer "workout_id"
    t.string "value"
    t.datetime "timestamp"
  end

  create_table "completed_sets", id: :serial, force: :cascade do |t|
    t.integer "user_id"
    t.integer "workout_id"
    t.datetime "complete_time"
    t.integer "exercise_id"
    t.integer "reps"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["user_id", "workout_id"], name: "index_completed_sets_on_user_id_and_workout_id"
  end

  create_table "completed_workouts", id: :serial, force: :cascade do |t|
    t.integer "user_id"
    t.datetime "complete_time"
    t.integer "workout_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean "mgr_override"
    t.string "override_comment"
    t.index ["user_id"], name: "index_completed_workouts_on_user_id"
    t.index ["workout_id"], name: "index_completed_workouts_on_workout_id"
  end

  create_table "exercises", id: :serial, force: :cascade do |t|
    t.string "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "goal_types", id: :serial, force: :cascade do |t|
    t.string "title"
    t.string "description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "roles", id: :serial, force: :cascade do |t|
    t.string "name"
    t.integer "resource_id"
    t.string "resource_type"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["name", "resource_type", "resource_id"], name: "index_roles_on_name_and_resource_type_and_resource_id"
    t.index ["name"], name: "index_roles_on_name"
  end

  create_table "users", id: :serial, force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: ""
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string "current_sign_in_ip"
    t.string "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string "name"
    t.string "time_zone", limit: 255, default: "UTC"
    t.string "invitation_token"
    t.datetime "invitation_created_at"
    t.datetime "invitation_sent_at"
    t.datetime "invitation_accepted_at"
    t.integer "invitation_limit"
    t.integer "invited_by_id"
    t.string "invited_by_type"
    t.integer "invitations_count", default: 0
    t.integer "reminder_threshold", default: 4
    t.boolean "notifications", default: true
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["invitation_token"], name: "index_users_on_invitation_token", unique: true
    t.index ["invitations_count"], name: "index_users_on_invitations_count"
    t.index ["invited_by_id"], name: "index_users_on_invited_by_id"
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  create_table "users_roles", id: false, force: :cascade do |t|
    t.integer "user_id"
    t.integer "role_id"
    t.index ["user_id", "role_id"], name: "index_users_roles_on_user_id_and_role_id"
  end

  create_table "workout_exercises", id: :serial, force: :cascade do |t|
    t.integer "workout_id"
    t.integer "exercise_id"
    t.integer "goal_type_id"
    t.integer "goal"
    t.string "comments"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["workout_id"], name: "index_workout_exercises_on_workout_id"
  end

  create_table "workouts", id: :serial, force: :cascade do |t|
    t.integer "challenge_id"
    t.string "title"
    t.text "motivation"
    t.date "start_date"
    t.date "end_date"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean "rest_day"
    t.index ["challenge_id"], name: "index_workouts_on_challenge_id"
  end

end
