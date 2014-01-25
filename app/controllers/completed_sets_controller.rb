class CompletedSetsController < ApplicationController
  
  def create
    completed_sets = params[:completed_sets]

    completed_sets.values.each do |cs|  #had to use "values" because it is coming across as a hash
      if not(cs[:reps].empty?)  # Only do it if there is a value for reps
        thisSet = CompletedSet.new(cs)
        thisSet.complete_time = Time.now # TODO: this should be local time for the client
        thisSet.save!

        #TODO: Need to add validations here
      end
    end

    redirect_to today_path

  end

  def edit
    @completed_set = CompletedSet.find(params[:id])
  end
  
  def update
    @completed_set = CompletedSet.find(params[:id])
    
    if @completed_set.update_attributes(params[:completed_set])
      flash[:notice] = "Successfully updated completed_set."
      redirect_to(today_path)
    else
      render :edit
      # TODO: eed to figure out this alternative path for error handling
    end


  end

  def destroy
  end

end