class CreateComments < ActiveRecord::Migration
  def change
  	create_table :comments do |t|
  		t.integer :user_id
      t.integer :workout_id
      t.string :value
      t.timestamp :timestamp
    end
  end
end