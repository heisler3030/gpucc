class ChangeCreatedbyToOwner < ActiveRecord::Migration
	def change
		rename_column :challenges, :created_by_id, :owner_id
	end
end
