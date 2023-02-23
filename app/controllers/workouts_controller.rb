class WorkoutsController < ApplicationController
  load_and_authorize_resource

  def index
  	@challenge = Challenge.find(params[:challenge_id])
  end
  
  def show
  	@workout = Workout.find(params[:id])

    # If user not specified or not found, use current
    @user = (params[:user] && (User.find_by_id(params[:user]) ) ? User.find(params[:user]) : current_user)
    @challenge_assignment = ChallengeAssignment.get(@user, @workout.challenge)
  end

  def new
  end
  
  def create
    @workout = Workout.new(workout_params)
    @challenge = Challenge.find(params[:challenge_id])
    @workout.challenge = @challenge

    # Set / Unset the rest_day flag on the workout as appropriate
    @workout.rest_day = self.rest_day?(workout_params)    

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
    @workout.rest_day = self.rest_day?(workout_params)    

    if @workout.update_attributes(workout_params)
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
    
    if workout[:workout_exercises_attributes] #&&
      # TODO: Figure out why this is broken on Rails 5
      # workout[:workout_exercises_attributes].map {|k,v| v["_destroy"] == "false" ? 0 : 1}.min == 0
    then
      # Not a Rest Day
      false
    else
      # Rest Day
      true
    end
  end

private
  def workout_params
    params.require(:workout).permit(
      :title, :motivation, :start_date, :end_date, :challenge_id, :rest_day, 
      workout_exercises_attributes: [:goal, :comments, :exercise_id, :goal_type_id, :workout_id]
    )
  end

end
