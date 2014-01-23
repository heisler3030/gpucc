class Challenge < ActiveRecord::Base
  attr_accessible :title, :description, :start_date, :end_date, :workouts_attributes

  has_many :workouts
  has_many :challenge_assignments
  has_many :users, :through => :challenge_assignments

  accepts_nested_attributes_for :workouts,
    	:allow_destroy => true,
    	:reject_if     => :all_blank

  belongs_to :created_by, :class_name => "User"

  validates_presence_of :title, :created_by

end
