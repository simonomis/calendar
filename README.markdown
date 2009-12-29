Calendar
========

A calendaring application using Rails and the event_calendar and redbox plugins from [elevation](http://github.com/elevation).

Use it to keep track of upcoming events and arrange for email reminders to be sent.

Setup Instructions
==================

For the reminder emails to work:
1. set the SMTP server config in config/environments/production.rb
2. edit script/reminders so that it has the correct path to the Calendar application
3. create a symbolic link to script/reminders from /etc/cron.daily:
	ln -s /path/to/calendar/script/reminders /etc/cron.daily/

