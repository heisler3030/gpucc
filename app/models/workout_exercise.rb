class WorkoutExercise < ActiveRecord::Base

  attr_accessible :goal, :comments, :exercise_id, :goal_type_id, :workout_id
  
  belongs_to :workout
  belongs_to :goal_type
  belongs_to :exercise
  
  validates :goal, :numericality => { :greater_than => 0 }
  #validates_presence_of :exercise, :goal_type, :workout
  validates_presence_of :exercise, :goal_type

  def completed_sets(user)
  	CompletedSet.where(workout_id: workout, user_id: user, exercise_id: exercise).order('complete_time DESC')
  end

  def reps_completed(user)
    completed_sets(user).map {|x| x.reps }.sum
  end

  def pct_complete(user)
  	((reps_completed(user).to_f / goal) * 100).to_i
  end

end


						# <% wa.workout_exercises.each do |we| %>

						# 	<%# Calculate Percent Complete (have to force floating point) %>
						# 	<% reps_done = wa.count_reps(we.exercise) %>
						# 	<% reps_goal = we.goal %>
						# 	<% pct_complete = ((reps_done.to_f/reps_goal) * 100).to_i %>
						# 	<% progress_status = pct_complete >= 100 ? "progress-bar progress-bar-success" : "progress-bar" %>
						# 	<% progress_width = pct_complete >= 100 ? 100 : pct_complete %>