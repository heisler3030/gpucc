class MissedWorkoutsController < ApplicationController
  before_action :authenticate_user!
  skip_authorization_check
  
  def show
  	@ca = ChallengeAssignment.find(params[:id])
    @mgr_exclusions = @ca.completed_workouts.where(:mgr_override => true, :user_id => @ca.user)
  end

end
