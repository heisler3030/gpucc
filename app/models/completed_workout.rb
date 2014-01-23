class CompletedWorkout < ActiveRecord::Base
  attr_accessible :completetime

  belongs_to :user
  has_one :workout

  validates :completetime, :presence => true
  validates :exercise, :presence => true

end
