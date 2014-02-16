class ChallengeAssignment < ActiveRecord::Base
  attr_accessible :join_date, :completed_date, :disqualify_date, :challenge_id, :user_id, :challenge

  belongs_to :challenge
  belongs_to :user

  validates_presence_of :user_id, :challenge_id
  validates_uniqueness_of :user_id, :scope => :challenge_id

  def get_status
  	if completed_date != nil
  		"Completed"
  	elsif disqualify_date != nil
  		"Disqualified"
  	else
  		"Participating"
  	end	
  end

  def completed_workouts
  	challenge.completed_workouts.where(user_id: user)
  end

  def completed_workouts_count
  	completed_workouts.count
  end

  def missed_workouts
  	#TODO: Only past workouts
  	challenge.workouts.where('id not in (select workout_id from completed_workouts where user_id = ?)', user_id) 
  end

  def missed_workouts_count
  	#TODO: Make this only count past workouts
  	#challenge.workouts.count - completed_workouts_count
  	missed_workouts.count
  	
  end

end
