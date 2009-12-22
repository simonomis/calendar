class Event < ActiveRecord::Base
  has_event_calendar
  
  has_many :reminders, :dependent => :destroy
  accepts_nested_attributes_for :reminders, :allow_destroy => true
end
