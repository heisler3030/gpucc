class Exercise < ApplicationRecord
  attr_accessible :name
  has_many :workout_exercises

  validates :name, uniqueness: true, presence: true
end
