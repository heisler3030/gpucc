class Exercise < ApplicationRecord
  has_many :workout_exercises

  validates :name, uniqueness: true, presence: true
end
