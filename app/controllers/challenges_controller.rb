class ChallengesController < ApplicationController
  #before_filter :authenticate_user!
  load_and_authorize_resource
  
  def index
  	@user = current_user
    @my_challenges = @user.challenges
    @available_challenges = Challenge.active.where.not(id: @my_challenges)
  end
  
  def show
    @challenge = Challenge.find(params[:id])
    @user = params[:user] || current_user

    @past_workouts = @challenge.past_workouts(@user)
    @completed_workouts = @challenge.workouts.completed(@user)
    @future_workouts = @challenge.workouts.future(@user)
    @active_workouts = @challenge.workouts.active(@user)

    @workoutmap = Hash.new{ |k,v| k[v] = { } }  # Init deeply-assignable hash
    add_workouts_to_map(@past_workouts, 'incomplete')
    add_workouts_to_map(@completed_workouts, 'completed')
    add_workouts_to_map(@active_workouts, 'active')
    add_workouts_to_map(@future_workouts, 'upcoming') if (@user == @challenge.owner) || (@user.has_role? :admin)
  end

  def edit
    @challenge = Challenge.find(params[:id])
    @owner = @challenge.owner
    @owners = User.with_role(:trainer).order(:name) + User.with_role(:admin).order(:name)

    respond_to do |format|
      format.html
    end
  end

  def manage_participants
    @challenge = Challenge.find(params[:id])
  end

  def new
    @challenge = Challenge.new
    @owner = current_user
    @owners = User.with_role([:admin])
  end
  
  
  def create

    @challenge = Challenge.new(params[:challenge])
    
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

  private
  
  def add_workouts_to_map(workouts, style)
    workouts.map do |w|
      @workoutmap[w["start_date"]]["url"] = ("/workouts/" + w['id'].to_s)
      @workoutmap[w["start_date"]]["class"] = style
      @workoutmap[w["start_date"]]["class"] = "#{style} restday" if w['rest_day'] == true
    end
  end


end
