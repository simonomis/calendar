class Reminder < ActiveRecord::Base
  belongs_to :event
  
  validates_format_of :email_address, :with => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i
  
  def send_today?
    day_to_send = event.start_at - days_before_to_send.days
    day_to_send.today?
  end
  
end
