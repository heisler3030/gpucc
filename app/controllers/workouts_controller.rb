class WorkoutsController < ApplicationController
  #before_filter :authenticate_user!
  load_and_authorize_resource

  def index
  	@challenge = Challenge.find(params[:challenge_id])
  end
  
  def show
  	@workout = Workout.find(params[:id])

    # If user not specified or not found, use current
    @user = (params[:user] && (User.find_by_id(params[:user]) ) ? User.find(params[:user]) : current_user)
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
      render :new
    end
     
  end

  def edit
    @workout = Workout.find(params[:id])
  end
  
  def update
    @workout = Workout.find(params[:id])
    @challenge = Challenge.find(@workout.challenge)

    # Set / Unset the rest_day flag on the workout as appropriate
    @workout.rest_day = self.rest_day?(params[:workout])    

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

#---------------- Helper Methods --------------------

  def rest_day?(workout)

    # See if there are any exercises that are not tagged for destroy
    # Unless == 0 there is at least one

    if workout[:workout_exercises_attributes] &&
       workout[:workout_exercises_attributes].map {|k,v| v["_destroy"] == "false" ? 0 : 1}.min == 0
    then
      logger.debug("NOT A REST DAY")
      false
    else
      logger.debug("IT'S A REST DAY!!!")
      true
    end
    #workout[:workout_exercises_attributes].select { |k,v| v.select { |k2, v2| v2 == "37" } }.size
  end

end
