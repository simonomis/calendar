class AddDaysBeforeToSendToReminder < ActiveRecord::Migration
  def self.up
    add_column :reminders, :days_before_to_send, :integer
  end

  def self.down
    remove_column :reminders, :days_before_to_send
  end
end
