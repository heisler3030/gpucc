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
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20140422043943) do

  create_table "challenge_assignments", :force => true do |t|
    t.integer  "user_id"
    t.integer  "challenge_id"
    t.date     "join_date"
    t.date     "completed_date"
    t.date     "disqualify_date"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
    t.date     "last_notified"
  end

  add_index "challenge_assignments", ["challenge_id"], :name => "index_challenge_assignments_on_challenge_id"
  add_index "challenge_assignments", ["user_id"], :name => "index_challenge_assignments_on_user_id"

  create_table "challenges", :force => true do |t|
    t.string   "title"
    t.text     "description"
    t.date     "start_date"
    t.date     "end_date"
    t.integer  "owner_id"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
    t.integer  "max_misses"
    t.date     "join_by"
  end

  create_table "comments", :force => true do |t|
    t.integer  "user_id"
    t.integer  "workout_id"
    t.string   "value"
    t.datetime "timestamp"
  end

  create_table "completed_sets", :force => true do |t|
    t.integer  "user_id"
    t.integer  "workout_id"
    t.datetime "complete_time"
    t.integer  "exercise_id"
    t.integer  "reps"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
  end

  add_index "completed_sets", ["user_id", "workout_id"], :name => "index_completed_sets_on_user_id_and_workout_id"

  create_table "completed_workouts", :force => true do |t|
    t.integer  "user_id"
    t.datetime "complete_time"
    t.integer  "workout_id"
    t.datetime "created_at",       :null => false
    t.datetime "updated_at",       :null => false
    t.boolean  "mgr_override"
    t.string   "override_comment"
  end

  add_index "completed_workouts", ["user_id"], :name => "index_completed_workouts_on_user_id"
  add_index "completed_workouts", ["workout_id"], :name => "index_completed_workouts_on_workout_id"

  create_table "exercises", :force => true do |t|
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "goal_types", :force => true do |t|
    t.string   "title"
    t.string   "description"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  create_table "roles", :force => true do |t|
    t.string   "name"
    t.integer  "resource_id"
    t.string   "resource_type"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
  end

  add_index "roles", ["name", "resource_type", "resource_id"], :name => "index_roles_on_name_and_resource_type_and_resource_id"
  add_index "roles", ["name"], :name => "index_roles_on_name"

  create_table "users", :force => true do |t|
    t.string   "email",                  :default => "",    :null => false
    t.string   "encrypted_password",     :default => "",    :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          :default => 0,     :null => false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at",                                :null => false
    t.datetime "updated_at",                                :null => false
    t.string   "name"
    t.string   "time_zone",              :default => "UTC"
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true

  create_table "users_roles", :id => false, :force => true do |t|
    t.integer "user_id"
    t.integer "role_id"
  end

  add_index "users_roles", ["user_id", "role_id"], :name => "index_users_roles_on_user_id_and_role_id"

  create_table "workout_exercises", :force => true do |t|
    t.integer  "workout_id"
    t.integer  "exercise_id"
    t.integer  "goal_type_id"
    t.integer  "goal"
    t.string   "comments"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
  end

  add_index "workout_exercises", ["workout_id"], :name => "index_workout_exercises_on_workout_id"

  create_table "workouts", :force => true do |t|
    t.integer  "challenge_id"
    t.string   "title"
    t.text     "motivation"
    t.date     "start_date"
    t.date     "end_date"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
    t.boolean  "rest_day"
  end

  add_index "workouts", ["challenge_id"], :name => "index_workouts_on_challenge_id"

end
