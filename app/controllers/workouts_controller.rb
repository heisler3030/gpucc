class WorkoutsController < ApplicationController

  before_filter :authenticate_user!
  
  def index
  	@workouts = Workout.all
  end
  
  def show
  	@workout = Workout.find(params[:id])
  end

  def new
    @workout = Workout.new
  end
  

  def create
    @workout =Workout.new(params[:workout])
    @challenge = Challenge.find(params[:challenge_id])
    @workout.challenge = @challenge

    if @workout.save
      flash[:notice] = "Successfully created workout."
      redirect_to(challenge_path(@challenge, :anchor => "workouts"))
    else
      render :action => 'new'
    end
     
  end

  def edit
    @workout = Workout.find(params[:id])
  end
  
  def update
    @workout = Workout.find(params[:id])
    @challenge = Challenge.find(@workout.challenge)
    if @workout.update_attributes(params[:workout])
      flash[:notice] = "Successfully updated workout."
      redirect_to(challenge_path(@challenge, :anchor => "workouts"))
    else
      render :edit
    end

  end

  def destroy
    @workout = Workout.find(params[:id])
    workout_date = @workout.start_date.strftime("%B %e, %Y")
    @challenge = Challenge.find(@workout.challenge)
    if @workout.destroy
      flash[:notice] = "Successfully deleted workout for " + workout_date
      redirect_to(challenge_path(@challenge, :anchor => "workouts")) 
    end
  end

end
