module EventsHelper
  
  def format_date date, show_time=true
    date.strftime("%a %d %b")
  end
  
  def f_date_full date
    f_dayname(date) << " " << f_day(date) << " " << f_month(date)
  end
  
  def same_day a, b
    a.day == b.day and a.month == b.month and a.year == b.year
  end
  
  def date_full ev
    str = ""
    if ev.all_day
      str << f_date_full(ev.start_at)
      str << " to " << f_date_full(ev.end_at) unless same_day(ev.start_at, ev.end_at)
    else
      str << f_date_full(ev.start_at) << " " << f_time(ev.start_at) << " to "
      str << f_date_full(ev.end_at) << " " unless same_day(ev.start_at, ev.end_at)
      str << f_time(ev.end_at)
    end
    str
  end
  
  def date_abbrev ev
    if ev.all_day
      if ev.start_at.day == ev.end_at.day
        "%s %s" % [ f_dayname(ev.start_at), f_day(ev.start_at) ]
      else
        "%s %s - %s" % [ f_dayname(ev.start_at), f_day(ev.start_at), f_day(ev.end_at) ]
      end
    else
      "%s %s %02d:%02d" % [ f_dayname(ev.start_at), f_day(ev.start_at),
                            ev.start_at.hour, ev.start_at.min ]
    end
  end
  
  def f_day date
    day = date.day
    case day
    when 11, 12, 13 then "#{day}th"
    else
      case day % 10
      when 1 then "#{day}st"
      when 2 then "#{day}nd"
      when 3 then "#{day}rd"
      else "#{day}th"
      end
    end
  end
  
  def f_dayname date
    date.strftime("%a")
  end
  
  def f_month date
    date.strftime("%b")
  end
  
  def f_time date
    date.strftime("%H:%M")
  end
  
end
