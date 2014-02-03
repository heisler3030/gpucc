class WorkoutActivity
	attr_accessor :completed_sets, :workout_exercises, :new_sets
	attr_reader :workout

	def initialize(workout, user)
		@workout = workout
		@completed_sets = CompletedSet.where("workout_id = ? AND user_id = ?", workout, user).order('complete_time DESC')
		@workout_exercises = @workout.workout_exercises
		@new_sets = []

    # Prepare the form inputs for a new set
    @workout_exercises.each do |we|
      # Create a new completedset for this user, exercise, workout
      new_sets.push(user.completed_sets.build(:exercise => we.exercise, :workout => workout, :user => user))
    end

	end

  def count_reps(exercise)
  	# Counts the total reps performed for a specific exercise within this WorkoutActivity
  	# Used for computing completion status

  	exercise_sets = @completed_sets.where(:exercise_id => exercise.id)
  	reps = 0
  	exercise_sets.each do |es|
  		reps += es.reps ? es.reps : nil
  	end

  	reps
  end

  def complete?
    complete_flag = true

    @workout_exercises.each do |we|
      if count_reps(we.exercise) < we.goal
        complete_flag = false
      end
    end

    return complete_flag

  end

end