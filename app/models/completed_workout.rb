class CompletedWorkout < ActiveRecord::Base
  attr_accessible :complete_time, :mgr_override, :override_comment, :user, :workout

  belongs_to :user
  belongs_to :workout

  #validates :complete_time, :presence => true
  validates :user, :presence => true
  validates :workout, :presence => true

end
