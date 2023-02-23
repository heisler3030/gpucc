require 'date'

module GpuccWorkoutHelper
## Automatically create workout if there is not already one in place
#

def auto_gpucc_workout(challenge_title)
  c = Challenge.find_by!(title: challenge_title)
  w = Workout.new(challenge_id: c.id, start_date: Date.current + 1)
  
  # Save will fail if there is already a workout today
  if w.save
    #Otherwise, create one with pushups and situps matching current day-of-year
    WorkoutExercise.create!(goal: Date.current.yday + 1, exercise_id: Exercise.find_by(name: 'Pushups').id, workout_id: w.id, goal_type_id: GoalType.find_by(title: 'Cumulative').id)
    WorkoutExercise.create!(goal: Date.current.yday + 1, exercise_id: Exercise.find_by(name: 'Situps').id, workout_id: w.id, goal_type_id: GoalType.find_by(title: 'Cumulative').id)
  end
end

end