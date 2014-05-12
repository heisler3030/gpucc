class CompletedSetsController < ApplicationController
  load_and_authorize_resource

  def create
    # Gets a hash of CompletedSets from the today's workout view
    
    logger.debug("CompletedSetsController#create")
    completed_sets = params[:completed_sets]

    logger.debug(completed_sets.inspect)

    this_workout = nil
    this_user = nil

    completed_sets.values.each do |cs|  #had to use "values" because it is coming across as a hash
      if not(cs[:reps].empty?)  # Only do it if there is a value for reps
        this_set = CompletedSet.new(cs)
        this_set.complete_time = Time.now # TODO: this should be local time for the client
        this_set.save!
        this_workout = this_set.workout
        this_user = this_set.user

        #TODO: Need to add validations here
      end
    end

    if not this_workout.nil?
      if this_workout.check_if_completed(this_user) then flash[:notice] = "Congratulations, you have finished the workout!" end
    end

    redirect_to today_path

  end

  def edit
    @completed_set = CompletedSet.find(params[:id])
  end
  
  def update
    @completed_set = CompletedSet.find(params[:id])

    logger.debug("Updating CompletedSet")
    
    if @completed_set.update_attributes(params[:completed_set])
      flash[:notice] = "Successfully updated Completed Set."
      @completed_set.workout.check_if_completed(@completed_set.user)
      redirect_to(today_path)
    else
      render :edit
      # TODO: eed to figure out this alternative path for error handling
    end


  end

  def destroy
  end

end