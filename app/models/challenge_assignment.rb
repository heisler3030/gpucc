class ChallengeAssignment < ActiveRecord::Base
  attr_accessible :join_date, :completed_date, :disqualify_date, :challenge_id, :user_id

  belongs_to :challenge
  belongs_to :user

  validates_presence_of :user_id, :challenge_id
  validates_uniqueness_of :user_id, :scope => :challenge_id

end
