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

    @assignment = ChallengeAssignment.new(params[:challenge_assignment])
    @assignment.join_date = Date.current()

    if @assignment.save
      flash[:notice] = "Successfully created assignment."
    end

    # Re-render Assignments
    @assignments = ChallengeAssignment.all
    render :index

  end
  
  def update
  end

  def destroy
  end

end
