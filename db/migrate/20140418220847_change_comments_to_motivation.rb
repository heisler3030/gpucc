class ChangeCommentsToMotivation < ActiveRecord::Migration
	def change
		rename_column :workouts, :comments, :motivation
	end
end
