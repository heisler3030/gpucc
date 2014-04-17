class ChallengeAssignment < ActiveRecord::Base
  attr_accessible :join_date, :completed_date, :disqualify_date, :challenge_id, :user_id, :challenge

  belongs_to :challenge
  belongs_to :user
  has_many :workouts, :through => :challenge
  has_many :completed_workouts, :through => :workouts

  validates_presence_of :user_id, :challenge_id
  validates_uniqueness_of :user_id, :scope => :challenge_id

  scope :active, where("disqualify_date IS NULL AND completed_date IS NULL")
  scope :completed, where("completed_date IS NOT NULL")
  scope :disqualified, where("disqualify_date IS NOT NULL")
  scope :inactive, where("disqualify_date IS NOT NULL OR completed_date IS NOT NULL")

  def status
  	if completed_date != nil
  		"Completed"
  	elsif disqualify_date != nil
  		"Disqualified"
  	else
  		"Active"
  	end	
  end

  def missed_workouts
  	challenge.past_workouts(user).where('workouts.id not in (select workout_id from completed_workouts where user_id = ?)', user_id) 
  end

  # Workouts that are active and incomplete
  def open_workouts
    if status = "Active"
      self.workouts.active(user)
    end
  end

  # Workouts that are active and incomplete
  def completed_workouts
    self.workouts.completed(user)
  end

end
