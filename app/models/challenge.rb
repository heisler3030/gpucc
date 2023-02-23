class Challenge < ApplicationRecord

  has_many :workouts
  has_many :challenge_assignments
  has_many :users, :through => :challenge_assignments
  has_many :completed_workouts, :through => :workouts
  has_many :workout_exercises, :through => :workouts

  accepts_nested_attributes_for :workouts,
    	:allow_destroy => true,
    	:reject_if     => :all_blank

  belongs_to :owner, :class_name => "User"

  validates_presence_of :title, :owner, :max_misses, :start_date, :end_date
  validates_numericality_of :max_misses
  validate :valid_date_range

  scope :active, -> { where("? BETWEEN START_DATE and END_DATE", Time.current.to_date) }

  # Workouts that are active on a specified date
  def get_active_workouts_for_day(date)
        self.workouts.where("? = start_date OR (? BETWEEN workouts.start_date AND workouts.end_date)", date, date)
  end

  # Workouts that are ending on a specified date
  def get_workouts_ending_for_day(date)
        self.workouts.where(["(? = workouts.start_date AND workouts.end_date is null) OR (? = workouts.end_date)", date, date]).order('start_date ASC')
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
  
  ## Returns array of Workouts in this challenge which have been completed by specified user
  #
  def completed_workouts_for_user(user)
    #challenge = self
    completed_workouts = user.completed_workouts.where(workout: self.workouts)
    cw_ids = []
    completed_workouts.map{ |cw| cw_ids.push(cw.workout_id) }
    Workout.where(id: cw_ids)
  end

   def rest_days
     self.workouts.where('rest_day is true')
   end

  def get_challenge_assignment_for(user)
    ChallengeAssignment.find_by_user_id_and_challenge_id(user, self)
  end

  def status
    #TODO:  Make this real
    # In Progress, Completed, Registration
    "In Progress"
  end

  def days_remaining
    (end_date - Time.current.to_date).to_i >= 0 ? (end_date - Time.current.to_date).to_i : 0
  end

  def valid_date_range
    return unless errors.blank?
    errors.add(:end_date, "End date must be later than start date") if start_date > end_date
  end

end
