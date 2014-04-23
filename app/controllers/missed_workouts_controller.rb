class MissedWorkoutsController < ApplicationController
  before_filter :authenticate_user!
  skip_authorization_check
  
  def show
  	@ca = ChallengeAssignment.find(params[:id])
    
    # Create an array of WorkoutActivities for each missed workout
    @missed_workout_activities = []
    @ca.missed_workouts.each { |mw| @missed_workout_activities.push(WorkoutActivity.new(mw, @ca.user)) }

    # Create an array of Manager-excluded workouts
    @mgr_exclusions = @ca.completed_workouts.where(:mgr_override => true)

  end

end
