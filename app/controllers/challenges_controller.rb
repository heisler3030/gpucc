class ChallengesController < ApplicationController
  before_filter :authenticate_user!
  
  def index
  	@challenges = Challenge.all
  end
  
  def show
  	@challenge = Challenge.find(params[:id])
    #@workouts = @challenge.workouts.order('start_date DESC')
    @upcoming_workouts = @challenge.workouts.where(["? <= start_date", DateTime.now]).order('start_date DESC')
    @past_workouts = @challenge.workouts.where(["? > start_date", DateTime.now]).order('start_date DESC')

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
