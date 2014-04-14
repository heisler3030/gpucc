class AddMaxMissesToChallenges < ActiveRecord::Migration
  def change
  	add_column :challenges, :max_misses, :int
  end
end
