class Challenge < ActiveRecord::Base
  attr_accessible :title, :description, :start_date, :end_date, :workouts_attributes, :max_misses, :join_by

  has_many :workouts
  has_many :challenge_assignments
  has_many :users, :through => :challenge_assignments
  has_many :completed_workouts, :through => :workouts
  has_many :workout_exercises, :through => :workouts

  accepts_nested_attributes_for :workouts,
    	:allow_destroy => true,
    	:reject_if     => :all_blank

  belongs_to :owner, :class_name => "User"

  validates_presence_of :title, :owner, :max_misses
  validates_numericality_of :max_misses

  # Workouts that are ending on a specified date
  def get_workouts_ending_for_day(date)
        self.workouts.where(["(? = workouts.start_date AND workouts.end_date is null) OR (? = workouts.end_date)", date, date]).order('start_date ASC')
  end

  # Workouts that start today or later, in a specific user's timezone
  def upcoming_workouts(user)
    self.workouts.where(["? <= workouts.start_date", user.current_date]).order('start_date ASC')
  end
  
  # Workouts that start today or later, in a specific user's timezone
  #TODO:  DOES NOT PROPERLY HANDLE MULTI-DAY
  def past_workouts(user)
  	self.workouts.where(["? > workouts.start_date", user.current_date]).order('start_date DESC')
  end

  def active_assignments
  	self.challenge_assignments.where('disqualify_date is null and completed_date is null')
  end

  def disqualified_assignments
  	self.challenge_assignments.where('disqualify_date is not null and completed_date is null')
  end

  def completed_assignments
  	self.challenge_assignments.where('completed_date is not null')
  end

   def rest_days
     self.workouts.where('rest_day is true')
   end

  def get_challenge_assignment_for(user)
    ChallengeAssignment.find_by_user_id_and_challenge_id(user, self)
  end

end
