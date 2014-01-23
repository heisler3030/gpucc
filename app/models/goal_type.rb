class GoalType < ActiveRecord::Base
  attr_accessible :title, :description
  has_many :workout_exercises
end
