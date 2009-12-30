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
    if not defined? $days_before_hash
      $days_before_hash = { 0 => "the same day", 1 => "the day before" }
      (2..6).each do |i|
        $days_before_hash[i] = "#{i} days before"
      end
      $days_before_hash[7] = "1 week before"
      (2..4).each do |i|
        $days_before_hash[i*7] = "#{i} weeks before"
      end
    end
    $days_before_hash
  end
  
  def days_before_array
    $days_before_array ||= days_before_hash.invert.select{ true }.sort{ |x,y| x[1] <=> y[1] }
  end
  
  def truncate str, max_len
    if str.length > max_len
      str[0..(max_len-3)] + "..."
    else
      str
    end
  end
  
  def reminder_defaults
    { :email_address => "email address", :days_before_to_send => 1 }
  end
  
  # For javascript adding deleting reminders
  def remove_link f
    icon = image_tag 'subtract.gif', :class => 'icon'
    if f.object.new_record?
      link_to_function(icon, "$(this).up('.#{f.object.class.name.underscore}').remove()", :title => "Remove")
    else
      f.hidden_field(:_delete) + link_to_function(icon, "$(this).up('.#{f.object.class.name.underscore}').hide(); $(this).previous().value = '1'", :title => "Remove")
    end
  end

  def add_link f
    icon = image_tag 'add.gif', :class => 'icon'
    link_to_function icon, :title => "Add" do |page|
      div = render('reminder', :pf => f, :ff_args => [:reminders, Reminder.new(reminder_defaults)])
      page << "$('reminders').insert({ bottom: '#{escape_javascript(div)}' });"
    end
  end
    
end
