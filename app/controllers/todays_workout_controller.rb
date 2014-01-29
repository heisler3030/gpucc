class TodaysWorkoutController < ApplicationController

  before_filter :authenticate_user!
  
  def index

    # Build a package for the view which consists of:
    #   All workouts that are current for the current user
    #     All completed_sets for each workout
    #     All the workout_exercises for each workout
    #     Pre-filled completed_sets for each workout_exercise
    #     Progress against each workout_exercise by summing the completed_sets
    #
    # Pass that package to the view



    @workout_activities = WorkoutsBundle.new(current_user, Time.now.in_time_zone(current_user.time_zone)).workout_activities

    respond_to do |format|
      format.html {render "/workouts/todays_workout"}
      format.json {render :json => @workout_activities}
    end

    

  end

  def create
    # Creates the completedsets
  end

end
