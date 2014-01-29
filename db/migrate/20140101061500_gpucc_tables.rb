class GpuccTables < ActiveRecord::Migration
  def change

    create_table :challenges do |t|
      t.string :title
      t.string :description
      t.date :start_date
      t.date :end_date
      t.belongs_to :created_by
      t.timestamps
    end

    create_table :workouts do |t|
      t.belongs_to :challenge
      t.string :title
      t.string :comments
      t.date :start_date
      t.date :end_date
      t.timestamps
    end
    add_index(:workouts, :challenge_id) 

    create_table :challenge_assignments do |t|
      t.belongs_to :user
      t.belongs_to :challenge
      t.date :join_date
      t.date :completed_date
      t.date :disqualify_date
      t.timestamps
    end
    add_index(:challenge_assignments, :user_id)
    add_index(:challenge_assignments, :challenge_id)

    create_table :workout_exercises do |t|
      t.belongs_to :workout
      t.belongs_to :exercise
      t.belongs_to :goal_type
      t.integer :goal
      t.string :comments
      t.timestamps
    end
    add_index(:workout_exercises, :workout_id)

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
    add_index(:completed_sets, [:user_id, :workout_id])

    create_table :completed_workouts do |t|
      t.belongs_to :user
      t.timestamp :complete_time
      t.belongs_to :workout
      t.timestamps
    end
    add_index(:completed_workouts, :user_id)
    add_index(:completed_workouts, :workout_id)
  end
end
