class AddColumnsToUsers < ActiveRecord::Migration
  def change
    add_column :users, :name, :string
    add_column :users, :time_zone, :string, :limit => 255, :default => "UTC"
  end
end
