class WorkoutsBundle
# builds and returns a collection of WorkoutActivities based on a specific user/date

  attr_reader :workout_activities

  def initialize(user, for_datetime)
    Rails.logger.debug "initializing WorkoutsBundle for user: " + user.name + ", on " + for_datetime.to_s

  	@workout_activities = []

    # Date filter for workouts - two possibilities: 
    #    - null end date and current time is between start_date and start_date + 1
    # OR
    #    - current time is between start_date and end_date + 1

    date_filter_sql_sqllite = "
      (workouts.end_date is null AND ? between workouts.start_date and datetime(workouts.start_date,'+1 days')) OR
      (? between workouts.start_date and datetime(workouts.end_date,'+1 days'))"

    date_filter_sql_postgres = "
      (workouts.end_date is null AND ? between workouts.start_date and (workouts.start_date + integer '1')) OR
      (? between workouts.start_date and (workouts.end_date + integer '1'))"

    date_filter_sql = date_filter_sql_postgres

    workouts = user.workouts.where(date_filter_sql, for_datetime, for_datetime)

  	workouts.each do |w|
      wa = WorkoutActivity.new(w)  # Info container for each workout and associated sets

      # Prepare the form inputs for a new set
  		new_sets = []
  		w.workout_exercises.each do |we|
  			# Create a new completedset for this user, exercise, workout
        t = user.completed_sets.build
  			new_sets.push(user.completed_sets.build(:exercise => we.exercise, :workout => w))
      end

      # Put everything into the WorkoutActivity package
      wa.completed_sets = w.completed_sets.order('complete_time DESC')
      wa.workout_exercises = w.workout_exercises
      wa.new_sets = new_sets	

		  #put the WorkoutActivity in the WorkoutsBundle
		  @workout_activities.push(wa)
    end

  end

end

class WorkoutActivity
	attr_accessor :completed_sets, :workout_exercises, :new_sets
	attr_reader :workout

	def initialize(workout)
		@workout = workout
		@completed_sets = []
		@workout_exercises = []
		@new_sets = []
	end

  def count_reps(exercise)
  	# Counts the total reps performed for a specific exercise within this WorkoutActivity
  	# Used for computing completion status

  	exercise_sets = @completed_sets.where(:exercise_id => exercise.id)
#    Rails.logger.debug "exercise_sets.inspect"
#    Rails.logger.debug "ex inspect " + exercise_sets.inspect
  	reps = 0
  	exercise_sets.each do |es|
  		reps += es.reps ? es.reps : nil
  	end

  	reps

  end

end