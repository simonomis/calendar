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
      :event_height => 17,
      :event_margin => 2,
      :event_padding_top => 2,
      :use_javascript => false
    }
  end

  def event_calendar
    calendar event_calendar_opts do |event|
      link_to_function event.name, "ajax_load_url('#{event_path(event)}')",
        :class => "ajax", :title => "#{h(event.name)}\n#{h(date_full(event))}"
    end
  end
  
  def new_event_link day
    link_to_function("+",
      "ajax_load_url('#{new_event_path(:day => day.day, :month => day.month, :year => day.year)}')",
      :class => "ec-day-add-event", :title => "Add Event")
  end
  
end
