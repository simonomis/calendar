class ReminderMailer < ActionMailer::Base
  
  def reminder_email reminder
    recipients    reminder.email_address
    from          "calendar@18leatherhead.homeip.net"
    subject       'Reminder for "' + reminder.event.name + '"'
    body          :event => reminder.event
    content_type  "text/html"
  end
  
end
