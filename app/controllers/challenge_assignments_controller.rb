class ChallengeAssignmentsController < ApplicationController
  #before_filter :authenticate_user!
  load_and_authorize_resource
  
  def index
  	@assignments = ChallengeAssignment.all
    @assignment = ChallengeAssignment.new
  end
  
  def show
  
    @challenge_assignment = ChallengeAssignment.find(params[:id])
    @challenge = @challenge_assignment.challenge
    @user = @challenge_assignment.user

    # If user not specified or not found, use current
    #@user = (params[:user] && (User.find_by_id(params[:user]) ) ? User.find(params[:user]) : current_user)

    @past_workouts = @challenge.workouts.order('start_date DESC')

    # respond_to do |format|
    #   format.html
    # end  

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
