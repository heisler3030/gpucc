class Workout < ActiveRecord::Base
  attr_accessible :title, :motivation, :start_date, :end_date, :challenge_id, :rest_day,:workout_exercises_attributes

  belongs_to :challenge
  
  has_many :workout_exercises, :dependent => :destroy
  #has_many :completed_sets
  has_many :completed_workouts
  has_many :comments
  
  accepts_nested_attributes_for :workout_exercises,
    	:allow_destroy => true,
    	:reject_if     => :all_blank
  
  validates_presence_of :start_date
  #validates_with WorkoutValidator

  # Return active workouts for a specific user
  # (Active for this date and not completed)
  scope :active, (lambda { |user| 
      active_sql = "? = workouts.start_date
                     AND (workouts.end_date IS NULL OR ? <= workouts.end_date) AND
                     workouts.id not in (select workout_id from completed_workouts where user_id = ?)"
      where(active_sql, user.current_date, user.current_date, user)
  } )

  # Return completed workouts for a specific user
  scope :completed, (lambda { |user|
    where('workouts.id in (select workout_id from completed_workouts where user_id = ? AND MGR_OVERRIDE IS NOT TRUE)', user) 
  })

  # check if active for a certain user (based on timezone)
  def active?(user)
    user.current_date == start_date && (end_date.is_nil? || user.current_date <= end_date) && not(complete?)
  end

  def complete?(user)
    not((CompletedWorkout.where("workout_id = ? AND user_id = ?", self, user)).empty?) 
  end

  # Return end time based on user timezone
  def ends_at(user)
    if end_date.nil?
      start_date.to_time.in_time_zone(user.time_zone).end_of_day
    else
      end_date.to_time.in_time_zone(user.time_zone).end_of_day
    end
  end

  def effective_date
    end_date ? start_date.strftime("%B %e, %Y") + " to " + end_date.strftime("%B %e, %Y") : start_date.strftime("%B %e, %Y")
  end

  # Return true if there are no exercises assigned
  def rest_day?
    rest_day
  end

  def time_remaining(user)
    (ends_at(user) - user.current_time) / 3600
  end

  def completed_sets(user)
    CompletedSet.where(workout_id: self, user_id: user).order('complete_time DESC')
  end

  # Check completion status and create new CompletedSet if needed
  def check_if_completed(user)
  	# can I refactor the workouts_bundle somehow for this?
  	logger.debug("Checking completion for workout " + id.to_s + " by user " + user.name.to_s)

  	if not((CompletedWorkout.where("workout_id = ? AND user_id = ?", self, user)).empty?)  # If a CompletedWorkout exists already, no further action
  		logger.debug("Already completed")
  		return false
  	elsif WorkoutActivity.new(self, user).complete?  # Otherwise, check if it is complete, and build a CompletedWorkout
  		logger.debug("Completed!  Creating new CompletedWorkout")
  		CompletedWorkout.create!(:user => user, :workout => self, :complete_time => Time.now)
  		return true
    else
	  	logger.debug("Not yet completed")
	  	return false
  	end
  end

end



