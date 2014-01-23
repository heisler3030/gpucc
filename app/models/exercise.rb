class Exercise < ActiveRecord::Base
  attr_accessible :name
  has_many :workout_exercises
end
