class CompletedSetsController < ApplicationController
  
  def index
  	@workouts = Workout.all
  end
  
  def show
  	@workout = Workout.find(params[:id])
  end

  def new
    @challenge = Challenge.find(params[:challenge_id])
    @workout = @challenge.workouts.build
    respond_with(@workout)
  end
  
  def create
    @challenge = Challenge.find(params[:challenge_id])    
    @workout = @challenge.workouts.build(params[:workout])
    @workout.save

    @workout.timestamp = Time.now
    @workout.exercise = Exercise.find(params[:workout][:exercise].to_i)
    @workout.reps = params[:workout][:reps].to_i
    
    redirect_to @workout
  end
  
  def update
  end

  def destroy
  end

end
