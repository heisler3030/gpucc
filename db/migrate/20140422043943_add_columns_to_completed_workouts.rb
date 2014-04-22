class AddColumnsToCompletedWorkouts < ActiveRecord::Migration
  def change
    add_column :completed_workouts, :mgr_override, :boolean
    add_column :completed_workouts, :override_comment, :string
  end
end
