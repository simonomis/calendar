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
      #%(<a href="/events/#{event.id}" title="#{h(event.name)}">#{h(event.name)}</a>)
      %(<a title="#{h(event.name)}\n#{h(date_full(event))}">#{h(event.name)}</a>)
    end
  end
end