class AddLastNotifiedToChallengeAssignment < ActiveRecord::Migration
  def change
    add_column :challenge_assignments, :last_notified, :date
  end
end
