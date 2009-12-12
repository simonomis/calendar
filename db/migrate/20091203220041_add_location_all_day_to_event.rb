class AddLocationAllDayToEvent < ActiveRecord::Migration
  def self.up
    add_column :events, :location, :string
    add_column :events, :all_day, :boolean
  end

  def self.down
    remove_column :events, :all_day
    remove_column :events, :location
  end
end
