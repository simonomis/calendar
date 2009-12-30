# This loads the custom config for the application
require 'yaml'

APP_CONFIG = YAML.load_file("#{RAILS_ROOT}/config/config.yml")

# Configure the SMTP server for reminder emails
ActionMailer::Base.smtp_settings[:address] = APP_CONFIG['smtp_server']
ActionMailer::Base.default_url_options[:host] = APP_CONFIG['hostname']
