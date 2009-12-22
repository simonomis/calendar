class RemoveSendAtFromReminder < ActiveRecord::Migration
  def self.up
    remove_column :reminders, :send_at
  end

  def self.down
    add_column :reminders, :send_at, :datetime
  end
end
