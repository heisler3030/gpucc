class Workout < ActiveRecord::Base
  attr_accessible :title, :comments, :start_date, :end_date, :workout_exercises_attributes, :challenge_id

  belongs_to :challenge
  
  has_many :workout_exercises, :dependent => :destroy
  has_many :completed_sets
  has_many :completed_workouts
  
  accepts_nested_attributes_for :workout_exercises,
    	:allow_destroy => true,
    	:reject_if     => :all_blank
  
  validates_presence_of :start_date


  # Check completion status and create new CompletedSet if needed
  def check_complete(for_user)
  	# can I refactor the workouts_bundle somehow for this?
  	logger.debug("Checking completion for workout " + id.to_s + " by user " + for_user.name.to_s)

  	if not((CompletedWorkout.where("workout_id = ? AND user_id = ?", self, for_user)).empty?)  # If a CompletedWorkout exists already, no further action
  		logger.debug("Already completed")
  		return false
  	elsif WorkoutActivity.new(self, for_user).complete?  # Otherwise, check if it is complete, and build a CompletedWorkout
  		logger.debug("Completed!  Creating new CompletedWorkout")
  		CompletedWorkout.create!(:user => for_user, :workout => self, :complete_time => Time.now)
  		return true
    else
	  	logger.debug("Not yet completed")
	  	return false
  	end
  end


end


