class CompletedSet < ActiveRecord::Base
  attr_accessible :reps, :complete_time, :exercise, :workout

  belongs_to :user
  belongs_to :exercise
  belongs_to :workout

  #validates :user, :presence => true
  validates :completetime, :presence => true
  validates :exercise, :presence => true
  validates :reps, :presence => true, :numericality => true

end
