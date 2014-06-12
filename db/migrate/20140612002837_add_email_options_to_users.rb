class AddEmailOptionsToUsers < ActiveRecord::Migration
  def change
    add_column :users, :reminder_threshold, :integer
    add_column :users, :notifications, :boolean
  end
end
