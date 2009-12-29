class Event < ActiveRecord::Base
  has_event_calendar
  
  has_many :reminders, :dependent => :destroy
  accepts_nested_attributes_for :reminders, :allow_destroy => true
  
  validates_presence_of :name, :start_at, :end_at
  
protected
  def validate_start_and_end
    errors.add("end_at", "must be after Start at") if end_at.nil? or end_at <= start_at
  end
  
  def validate
    super
    validate_start_and_end
  end

end
