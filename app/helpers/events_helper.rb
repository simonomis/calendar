module EventsHelper
  
  def date_string date, all_day
    date.strftime("%d/%m/%Y" + (all_day ? "" : " %H:%M"))
  end
  
  def event_start_string ev
    date_string ev.start_at, ev.all_day
  end
  
  def event_end_string ev
     date_string ev.end_at, ev.all_day
  end
  
end
