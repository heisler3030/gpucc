class Workout < ActiveRecord::Base
  attr_accessible :title, :comments, :start_date, :end_date, :workout_exercises_attributes, :challenge_id

  belongs_to :challenge
  
  has_many :workout_exercises, :dependent => :destroy
  has_many :completed_sets
  
  accepts_nested_attributes_for :workout_exercises,
    	:allow_destroy => true,
    	:reject_if     => :all_blank
  
  validates_presence_of :start_date

end
