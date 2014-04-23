class CompletedWorkoutsController < ApplicationController
  load_and_authorize_resource

  def new
    @completed_workout = CompletedWorkout.new()
    @completed_workout.user = User.find(params[:user])
    @completed_workout.workout = Workout.find(params[:workout])
    session[:return_to] ||= request.referer
  end

  def create
    completed_workout = CompletedWorkout.new(params[:completed_workout])
    completed_workout.mgr_override = true

    if completed_workout.save

      flash[:notice] = "Successfully created Exclusion."
      
      # Re-check qualification status
      ChallengeAssignment.get(completed_workout.user, completed_workout.workout.challenge).check_status
      
      redirect_to session.delete(:return_to)
    else
      render :new
    end

  end

end