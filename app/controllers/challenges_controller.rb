class ChallengesController < ApplicationController
  #before_filter :authenticate_user!
  load_and_authorize_resource
  
  def index
  	@user = current_user
    @my_challenges = @user.my_challenges
    @available_challenges = Challenge.active.where.not(id: @my_challenges)
  end
  
  def show
  	@challenge = Challenge.find(params[:id])

    # If user not specified or not found, use current
    @user = (params[:user] && (User.find_by_id(params[:user]) ) ? User.find(params[:user]) : current_user)

    @upcoming_workouts = @challenge.upcoming_workouts(@user)
    @workouts = @challenge.current_and_past_workouts(@user)

    respond_to do |format|
      format.html
      format.json {render :json => @challenge}
    end
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

end
