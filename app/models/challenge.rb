class Challenge < ActiveRecord::Base
  attr_accessible :title, :description, :start_date, :end_date, :workouts_attributes

  has_many :workouts
  has_many :challenge_assignments
  has_many :users, :through => :challenge_assignments
  has_many :completed_workouts, :through => :workouts

  accepts_nested_attributes_for :workouts,
    	:allow_destroy => true,
    	:reject_if     => :all_blank

  belongs_to :created_by, :class_name => "User"

  validates_presence_of :title, :created_by

  def active_participants
  	self.challenge_assignments.where('disqualify_date is null and completed_date is null')
  end

  def disqualified_participants
  	self.challenge_assignments.where('disqualify_date is not null and completed_date is null')
  end

  def completed_participants
  	self.challenge_assignments.where('completed_date is not null')
  end

end
