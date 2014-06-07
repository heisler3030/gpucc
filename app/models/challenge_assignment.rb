class ChallengeAssignment < ActiveRecord::Base
  attr_accessible :join_date, :completed_date, :disqualify_date, :last_notified, :challenge_id, :user_id  #, :challenge_id, :user_id

  belongs_to :challenge
  belongs_to :user
  has_many :workouts, :through => :challenge
  #has_many :completed_workouts, :through => :workouts

  validates_presence_of :user_id, :challenge_id
  validates_uniqueness_of :user_id, :scope => :challenge_id

  scope :active, where("disqualify_date IS NULL AND completed_date IS NULL")
  scope :completed, where("completed_date IS NOT NULL")
  scope :disqualified, where("disqualify_date IS NOT NULL")
  scope :inactive, where("disqualify_date IS NOT NULL OR completed_date IS NOT NULL")

  # Class method for retrieving Assignment
  def self.get(user, challenge)
    ChallengeAssignment.find_by_user_id_and_challenge_id(user, challenge)
  end

  # Return human-readable identifier
  def name
    challenge.title + " - " + user.name
  end

  # Return current status
  def status
  	if completed_date != nil
  		:Completed
  	elsif disqualify_date != nil
  		:Disqualified
  	else
  		:Active
  	end	
  end

  def missed_workouts
  	challenge.past_workouts(user).where(
      'workouts.id not in (select workout_id from completed_workouts where user_id = ?) 
       and workouts.rest_day is not true', user_id) 
  end

  # Workouts that are active and incomplete
  def open_workouts
    if status == :Active
      self.workouts.active(user)
    else
      []
    end
  end

  def completed_workouts
    CompletedWorkout.where(user_id: user_id, workout_id: challenge.workouts)
  end

  def remaining_misses
    self.challenge.max_misses - self.missed_workouts.count
  end

  # Evaluate status and reset as required
  # TODO: Needs logic for handling completed challenges
  def check_status
    #puts ("Checking Status for " + self.user.name + " on " + self.challenge.title)
    #logger.debug("Checking Status for " + self.user.name + " on " + self.challenge.title)
    remaining_misses <= 0 ? set_status(:Disqualified) : set_status(:Active)
  end

  # Set status, only saving when it is a state change
  def set_status(status_string)
    case status_string
      when :Completed # Set completed_date to today
        unless status == :Completed
          logger.debug ("Changing Status for " + self.user.name + " on " + self.challenge.title + " to Completed")
          self.completed_date = DateTime.now.to_date
          self.disqualify_date = nil
          self.save!
        end
      when :Disqualified # Set disqualify_date to today
        unless status == :Disqualified
          logger.debug ("Changing Status for " + self.user.name + " on " + self.challenge.title + " to Disqualified")
          self.completed_date = nil
          self.disqualify_date = DateTime.now.to_date
          self.save!
        end
      when :Active # Clear completed / disqualify dates
        unless status == :Active
          logger.debug ("Changing Status for " + self.user.name + " on " + self.challenge.title + " to Active")
          self.completed_date = nil
          self.disqualify_date = nil
          self.save!
        end
      else
        raise Exception("Bad Status")
    end
  end
end
