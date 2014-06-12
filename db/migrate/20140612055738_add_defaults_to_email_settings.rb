class AddDefaultsToEmailSettings < ActiveRecord::Migration
  def change
  	change_column :users, :reminder_threshold, :integer, :default => 4
  	change_column :users, :notifications, :boolean, :default => true
  end
end
