class Comment < ActiveRecord::Base

  attr_accessible :user_id, :workout_id, :value, :timestamp
  
  belongs_to :workout
  belongs_to :user

end
