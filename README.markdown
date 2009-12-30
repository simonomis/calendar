Calendar
========

A calendaring application using Rails and the event_calendar and redbox plugins from [elevation](http://github.com/elevation).

Use it to keep track of upcoming events and arrange for email reminders to be sent.

Setup Instructions
==================

To install it on a production server, edit <code>config/deploy.rb</code> to have the correct variable (e.g. server, repository, etc), then:

1. <pre><code>cap deploy:setup</code></pre> (will prompt for an SMTP server and web server hostname)
2. <pre><code>cap deploy:cold</code></pre>

Then after the first deploy, just do the following to update the code:

	cap deploy
