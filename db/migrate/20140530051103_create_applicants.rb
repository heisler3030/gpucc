class CreateApplicants < ActiveRecord::Migration
  def change
    create_table :applicants do |t|
      t.string :email
      t.timestamps
    end
  end
end
