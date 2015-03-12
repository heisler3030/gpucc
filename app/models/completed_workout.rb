class CompletedWorkout < ActiveRecord::Base
  attr_accessible :complete_time, :mgr_override, :override_comment, :user, :workout, :user_id, :workout_id

  belongs_to :user
  belongs_to :workout
  has_one :challenge_assignment, 
    :through => :user, 
    :source => :challenge_assignments

  validates_presence_of :complete_time, :user, :workout, :challenge_assignment
  validates_uniqueness_of :user_id, :scope => :workout_id 

  # Class method for retrieving CompletedWorkout
  def self.get(user, workout)
    CompletedWorkout.find_by_user_id_and_workout_id(user, workout)
  end

end
