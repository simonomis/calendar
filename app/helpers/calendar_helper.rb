module CalendarHelper
  
  def month_link(month_date)
    link_to(month_date.strftime("%B"), {:month => month_date.month, :year => month_date.year}, :class => 'month_link')
  end
  
  # custom options for this calendar
  def event_calendar_opts
    { 
      :year => @year,
      :month => @month,
      :event_strips => @event_strips,
      :month_name_text => @shown_month.strftime("%B %Y"),
      :previous_month_text => "<< " + month_link(@shown_month.last_month),
      :next_month_text => month_link(@shown_month.next_month) + " >>",
      :abbrev => (0..-1),
      :event_height => 18,
      :event_margin => 2,
      :event_padding_top => 3,
      :use_javascript => true,
      :use_all_day => true
    }
  end

  def event_calendar
    calendar event_calendar_opts do |args|
      event, day = args[:event], args[:day]
      event_display = display_event_time(event, day) + event.name
      link_to_remote_redbox event_display, { :method => "get",
        :url => { :controller => "events", :action => "show", :id => event.id } },
        :class => "ajax", :title => event.name
    end
  end
  
  def new_event_link day
    icon = image_tag 'add.gif', :class => 'icon' #, :height => 12, :width => 12
    link_to_remote_redbox icon, { :method => "get",
      :url => { :controller => "events", :action => "new",
        :day => day.day, :month => day.month, :year => day.year } },
      :class => "ec-day-add-event ajax", :style => "display: none", :title => "Add Event"
  end
  
  def display_event_time(event, day)
    time = event.start_at
    if !event.all_day and time.to_date == day
      %(<span class="ec-event-time">#{time.strftime("%H:%M")}</span>)
    else
      ""
    end
  end
  
end
