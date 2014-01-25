class CompletedSetsController < ApplicationController
  
  def create
    completed_sets = params[:completed_sets]

    completed_sets.values.each do |cs|
      thisSet = CompletedSet.new(cs)
      thisSet.complete_time = Time.now # TODO: this should be local time for the client
      thisSet.save!

      #TODO: Need to add validations here
    end

    redirect_to "/today"

  end

  def edit
    @completed_set = CompletedSet.find(params[:id])
    logger.debug "Got Here's my completed_set"
    logger.debug @completed_set.inspect
  end
  
  def update
  end

  def destroy
  end

end