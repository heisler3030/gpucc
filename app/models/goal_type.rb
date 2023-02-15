class GoalType < ApplicationRecord
  attr_accessible :title, :description
  has_many :workout_exercises
end
