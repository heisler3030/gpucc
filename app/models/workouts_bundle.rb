class WorkoutsBundle
# builds and returns a collection of WorkoutActivities based on a specific user/date

  attr_reader :workout_activities

  def initialize(user, for_datetime)
    Rails.logger.debug "initializing WorkoutsBundle for user: " + user.name + ", on " + for_datetime.to_s

  	@workout_activities = []

    # Date filter for workouts - two possibilities: 
    #    - null end date and current time is start_date
    # OR
    #    - current time is between start_date and end_date (between is inclusive)

    date_filter_sql_sqllite = "
      (workouts.end_date is null AND ? between workouts.start_date and datetime(workouts.start_date,'+1 days')) OR
      (? between workouts.start_date and workouts.end_date))"

    date_filter_sql_postgres = "
      (workouts.end_date is null AND ? = workouts.start_date) OR
      (? between workouts.start_date and workouts.end_date)"

    date_filter_sql = date_filter_sql_postgres

    # Convert for_datetime to date to avoid timezone issues
    workouts = user.workouts.where(date_filter_sql, for_datetime.to_date, for_datetime.to_date)

  	workouts.each do |w|
      wa = WorkoutActivity.new(w, user)  # Info container for each workout and associated sets

		  #put the WorkoutActivity in the WorkoutsBundle
		  @workout_activities.push(wa)
    end

  end

end