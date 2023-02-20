class WorkoutExercise < ApplicationRecord

  
  belongs_to :workout
  belongs_to :goal_type
  belongs_to :exercise
  
  validates :goal, :numericality => { :greater_than => 0 }
  #validates_presence_of :exercise, :goal_type, :workout
  validates_presence_of :exercise, :goal_type

  def completed_sets(user)
  	CompletedSet.where(workout_id: workout, user_id: user, exercise_id: exercise).order('complete_time DESC')
  end

  def reps_completed(user)
    completed_sets(user).map {|x| x.reps }.sum
  end

  def pct_complete(user)
  	((reps_completed(user).to_f / goal) * 100).to_i
  end

  def complete?(user)
    pct_complete(user) >= 100
  end

end