class GpuccTables < ActiveRecord::Migration
  def change

    create_table :challenges do |t|
      t.string :title
      t.string :description
      t.datetime :start_date
      t.datetime :end_date
      t.belongs_to :created_by
      t.timestamps
    end

    create_table :workouts do |t|
      t.belongs_to :challenge
      t.string :title
      t.string :comments
      t.datetime :start_date
      t.datetime :end_date
      t.belongs_to :exercise
      t.timestamps
    end

    create_table :challenge_assignments do |t|
      t.belongs_to :user
      t.belongs_to :challenge
      t.timestamp :join_date
      t.timestamp :completed_date
      t.timestamp :disqualify_date
      t.timestamps
    end

    create_table :workout_exercises do |t|
      t.belongs_to :workout
      t.belongs_to :exercise
      t.belongs_to :goal_type
      t.integer :goal
      t.string :comments
      t.timestamps
    end

    create_table :exercises do |t|
      t.string :name
      t.timestamps
    end

    create_table :goal_types do |t|
      t.string :title
      t.string :description
      t.timestamps
    end

    create_table :completed_sets do |t|
      t.belongs_to :user
      t.belongs_to :workout
      t.timestamp :complete_time
      t.belongs_to :exercise
      t.integer :reps
      t.timestamps
    end

    create_table :completed_workouts do |t|
      t.belongs_to :user
      t.timestamp :complete_time
      t.belongs_to :workout
      t.timestamps
    end
  end
end
