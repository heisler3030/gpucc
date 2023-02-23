class ExercisesController < ApplicationController
  load_and_authorize_resource
  
  def index
    @exercises = Exercise.all
  end

  def show
    @exercise = Exercise.find(params[:id])
  end
  
  def new
  end
  
  def create
    #render text: params[:exercise].inspect
    @exercise = Exercise.new(exercise_params)
    @exercise.save
    redirect_to @exercise
  end
  
private

  def exercise_params 
    params.require(:exercise).permit(:name)
  end

end
