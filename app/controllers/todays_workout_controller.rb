class TodaysWorkoutController < ApplicationController
  before_filter :authenticate_user!
  skip_authorization_check
  
  def index

    @user = current_user

    current_user_time = Time.now.in_time_zone(@user.time_zone)
    current_user_date = Time.now.in_time_zone(@user.time_zone).to_date
    logger.debug("Current time in user timezone is " + current_user_time.to_s + " and date is " + current_user_date.to_s)

    @active_workouts = Workout.active(@user)

    respond_to do |format|
      format.html #{render "/workouts/todays_workout"}
      format.json {render :json => @workout_activities}
    end

    

  end

  def create
    # Creates the completedsets
  end

end
