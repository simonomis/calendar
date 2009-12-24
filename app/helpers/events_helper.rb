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
  
  def days_before_hash
    #return @h unless @h.nil?
    @h = { 0 => "the same day", 1 => "the day before" }
    (2..6).each do |i|
      @h[i] = "#{i} days before"
    end
    @h[7] = "1 week before"
    (2..4).each do |i|
      @h[i*7] = "#{i} weeks before"
    end
    @h
  end
  
  def days_before_array
    #return @a unless @a.nil?
    @a = days_before_hash.invert.select{ true }.sort{ |x,y| x[1] <=> y[1] }
  end
  
  def truncate str, max_len
    return str unless str.length > max_len
    str[0..(max_len-3)] + "..."
  end
  
  def reminder_defaults
    { :email_address => "email address", :days_before_to_send => 1 }
  end
  
  # For javascript adding deleting reminders
  def remove_link f
    icon = image_tag 'subtract.gif', :class => 'icon'
    if f.object.new_record?
      link_to_function icon, "$(this).up('.#{f.object.class.name.underscore}').remove()", :title => "Remove"
    else
      out = ''
      out << f.hidden_field(:_delete)
      out << link_to_function(icon, "$(this).up('.#{f.object.class.name.underscore}').hide(); $(this).previous().value = '1'", :title => "Remove")
      out
    end
  end

  def add_link f
    icon = image_tag 'add.gif', :class => 'icon'
    link_to_function icon, :title => "Add" do |page|
      div = render('reminder', :pf => f, :ff_args => [:reminders, Reminder.new(reminder_defaults)])
      page << "$('reminders').insert({ bottom: '#{ escape_javascript div }' });"
    end
  end
    
end
