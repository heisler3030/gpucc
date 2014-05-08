class ChallengesController < ApplicationController
  #before_filter :authenticate_user!
  load_and_authorize_resource


  
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

    respond_to do |format|
      format.html
      format.json {render :json => @challenge}
    end
  end


  def edit
    @challenge = Challenge.find(params[:id])
    @upcoming_workouts = @challenge.upcoming_workouts(current_user)

    respond_to do |format|
      format.html
    end
  end


  def new
    @challenge = Challenge.new
  end
  
  
  def create

    @challenge = Challenge.new(params[:challenge])
    @challenge.owner = current_user

    if @challenge.save
      flash[:notice] = "Successfully created challenge."
      redirect_to @challenge
    else
      render :action => 'new'
    end

  end
  
  
  def update
    @challenge = Challenge.find(params[:id])
    if @challenge.update_attributes(params[:challenge])
      flash[:notice] = "Successfully updated challenge."
      redirect_to(@challenge)
    else
      render :edit
    end

  end

  
  def destroy
  end

end
