class WorkoutExercise < ActiveRecord::Base

  attr_accessible :goal, :comments, :exercise_id, :goal_type_id, :workout_id
  
  belongs_to :workout
  belongs_to :goal_type
  belongs_to :exercise
  
  validates :goal, :numericality => { :greater_than => 0 }
  #validates_presence_of :exercise, :goal_type, :workout
  validates_presence_of :exercise, :goal_type

end
