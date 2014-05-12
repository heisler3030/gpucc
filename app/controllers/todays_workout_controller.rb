class TodaysWorkoutController < ApplicationController
  before_filter :authenticate_user!
  skip_authorization_check
  
  def index

    @user = current_user
    user_time = Time.now.in_time_zone(@user.time_zone)
    user_date = Time.now.in_time_zone(@user.time_zone).to_date

    logger.debug("TodaysWorkoutController: Current time for " + @user.name + " is " + user_time.to_s + " and date is " + user_date.to_s)

    @active_workouts = Workout.active(@user)

    respond_to do |format|
      format.html #{render "/workouts/todays_workout"}
    end

  end

  def create
    # Creates the completedsets
  end

end
