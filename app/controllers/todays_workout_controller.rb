class TodaysWorkoutController < ApplicationController
  before_filter :authenticate_user!
  skip_authorization_check
  
  def index

    # Build a package for the view which consists of:
    #     All workouts that are current for the current user
    #     All completed_sets for each workout
    #     All the workout_exercises for each workout
    #     Pre-filled completed_sets for each workout_exercise
    #     Progress against each workout_exercise by summing the completed_sets
    #
    # Pass that package to the view


    # Get the WorkoutsBundle for current user based on the current time in their timezone
    @user = current_user

    current_user_time = Time.now.in_time_zone(@user.time_zone)
    current_user_date = Time.now.in_time_zone(@user.time_zone).to_date
    logger.debug("Current time in user timezone is " + current_user_time.to_s + " and date is " + current_user_date.to_s)

    @workout_activities = WorkoutsBundle.new(@user, current_user_time).workout_activities

    respond_to do |format|
      format.html #{render "/workouts/todays_workout"}
      format.json {render :json => @workout_activities}
    end

    

  end

  def create
    # Creates the completedsets
  end

end
