class AddJoinByToChallenges < ActiveRecord::Migration
  def change
    add_column :challenges, :join_by, :date
  end
end
