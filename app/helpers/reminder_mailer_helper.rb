
module ReminderMailerHelper

  include EventsHelper
  
  # for inlining the stylesheet in emails
  def inline_stylesheet source
    "<style type='text/css'>" +
    File.read("#{RAILS_ROOT}/public/stylesheets/#{source}") +
    "</style>"
  end
  
end
