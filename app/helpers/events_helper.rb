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
  
  # For javascript adding deleting reminders
  def remove_link f
    icon = image_tag 'subtract.gif', :class => 'icon'
    if f.object.new_record?
      link_to_function icon, "$(this).up('.#{f.object.class.name.underscore}').remove()"
    else
      out = ''
      out << f.hidden_field(:_delete)
      out << link_to_function(icon, "$(this).up('.#{f.object.class.name.underscore}').hide(); $(this).previous().value = '1'")
      out
    end
  end

  def add_link f
    icon = image_tag 'add.gif', :class => 'icon'
    link_to_function icon do |page|
      div = render('reminder', :pf => f, :ff_args => [:reminders, Reminder.new])
      page << "$('reminders').insert({ bottom: '#{ escape_javascript div }' });"
    end
  end
    
end
