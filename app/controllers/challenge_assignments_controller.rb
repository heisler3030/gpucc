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
      flash[:notice] = @assignment.user.name + " has successfully joined " + @assignment.challenge.title + "."
    end

    # Re-render Assignments
    #@assignments = ChallengeAssignment.all
    #render :index

    redirect_to request.referer

  end
  
  def update
  end

  def destroy
    @assignment = ChallengeAssignment.find(params[:id])
    user = @assignment.user.name
    challenge = @assignment.challenge.title
    if @assignment.destroy
      flash[:notice] = "Successfully removed " + user + " from " + challenge + "."
      redirect_to request.referer
    end
  end

end
