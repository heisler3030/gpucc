class AddRestDayToWorkouts < ActiveRecord::Migration
  def change
    add_column :workouts, :rest_day, :boolean
  end
end
