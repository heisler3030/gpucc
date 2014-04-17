class ChallengesController < ApplicationController
  before_filter :authenticate_user!
  
  def index

    challenge_assignment_list = current_user.challenge_assignments.map(&:challenge_id).push(-1)

    # Have to throw an extra fake element in the array in case there are no challenge assignments for this user
    @my_challenges = Challenge.find(:all, :conditions => {:id => (challenge_assignment_list)})
    @available_challenges = Challenge.find(:all, :conditions => ['id not in (?)', (challenge_assignment_list)])

  end
  
  def show
  	@challenge = Challenge.find(params[:id])
    @upcoming_workouts = @challenge.upcoming_workouts(current_user)
    @past_workouts = @challenge.past_workouts(current_user)

    @workoutsMatrix = Hash.new
    @challenge.workouts.each do |w|
      @workoutsMatrix[w] = w.workout_exercises
    end

    respond_to do |format|
      format.html
      format.json {render :json => @challenge}
    end
  end

  def new
    @challenge = Challenge.new
  end
  
  def create
    #render text: params[:workout].inspect

    # respond_to do |format|
    #   format.html {render :json => params}
    # end
    

    @challenge = Challenge.new(params[:challenge])
    @challenge.created_by = current_user

    if @challenge.save
      flash[:notice] = "Successfully created challenge."
      redirect_to @challenge
    else
      render :action => 'new'
    end

  end
  
  def update
  end

  def destroy
  end

end
