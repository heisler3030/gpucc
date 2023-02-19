class ChallengeAssignmentsController < ApplicationController
  load_and_authorize_resource
  
  def index
  	@assignments = ChallengeAssignment.all
    @assignment = ChallengeAssignment.new
  end
  
  def show
    @challenge_assignment = ChallengeAssignment.find(params[:id])
    @challenge = @challenge_assignment.challenge
    @user = @challenge_assignment.user
    @past_workouts = @challenge.workouts.active(@user) + @challenge.workouts.past(@user).order('start_date DESC')
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
