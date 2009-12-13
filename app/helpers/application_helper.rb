# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper
  
  def ajax_month_str
    "ajax_load_url('#{month_path(nil)}/' + $('#side').attr('year') +'/'+ $('#side').attr('month'))"
  end
  
end
