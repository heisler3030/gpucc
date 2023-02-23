class CompletedWorkoutsController < ApplicationController
  load_and_authorize_resource

  def new
    @completed_workout = CompletedWorkout.new()
    @completed_workout.user = User.find(params[:user])
    @completed_workout.workout = Workout.find(params[:workout])
    session[:return_to] ||= request.referer
  end

  def create
    completed_workout = CompletedWorkout.new(completed_workout_params)
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

  private
  def completed_workout_params
    params.require(:completed_workout).permit(:complete_time, :mgr_override, :override_comment, :user, :workout, :user_id, :workout_id)
  end

end