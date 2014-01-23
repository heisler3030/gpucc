class ChallengeAssignmentsController < ApplicationController
  before_filter :authenticate_user!
  
  def index
  	@assignments = ChallengeAssignment.all
    @assignment = ChallengeAssignment.new
  end
  
  def show

  end

  def new
    @assignment = ChallengeAssignment.new
  end
  
  def create
    #render text: params[:workout].inspect

    # respond_to do |format|
    #   format.html {render :json => params}
    # end
    

    @assignment = ChallengeAssignment.new(params[:challenge_assignment])
    @assignment.join_date = Date.current()

    if @assignment.save
      flash[:notice] = "Successfully created assignment."
    end

    @assignments = ChallengeAssignment.all
    render "/workouts/todays_workout"

  end
  
  def update
  end

  def destroy
  end

end
