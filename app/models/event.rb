class Event < ActiveRecord::Base
  has_many :reminders, :dependent => :destroy
  has_event_calendar
end
