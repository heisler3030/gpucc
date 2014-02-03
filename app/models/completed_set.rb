class CompletedSet < ActiveRecord::Base
  attr_accessible :reps, :complete_time, :exercise_id, :workout_id, :user_id, :exercise, :workout, :user

  belongs_to :user
  belongs_to :exercise
  belongs_to :workout

  validates :complete_time, :presence => true
  validates :user, :presence => true
  validates :exercise, :presence => true
  validates :reps, :presence => true, :numericality => true

end
