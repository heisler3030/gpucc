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
    @exercise = Exercise.new(params[:exercise])
    @exercise.save
    redirect_to @admin::exercise
  end
  
end
