set :application, "calendar"
set :repository,  "git://github.com/simonomis/calendar.git"

set :scm, :git
set :branch, "master"

#set :scm_verbose, "true" # because git in Freelink Debian doesn't support -q on checkouts

server "macserver", :web, :app, :db, { :primary => true }
set :user, "deploy"
set :use_sudo, false

set :apache_root, "/var/www"
set :deploy_to, "#{apache_root}/rails/#{application}"
set :deploy_via, :remote_cache # so it only gets the changes from github

# in case we get a github login
default_run_options[:pty] = true

namespace :deploy do

  desc "Start the Rails application"
  task :start do
    run "touch #{current_release}/tmp/restart.txt"
  end

  desc "Stop the Rails application"
  task :stop do
    # nothing to do
  end

  desc "Restart the Rails application"
  task :restart do
    run "touch #{current_release}/tmp/restart.txt"
  end
 
  namespace :symlinks do

    desc "Creates the symlink in www root to the rails application"
    task :rails do
      run "ln -nfs #{deploy_to}/#{current_dir}/public #{apache_root}/#{application}"
    end

    desc "Creates the symlink in /etc/cron.daily to the reminders email script"
    task :reminders do
      run "ln -nfs #{current_path}/script/reminders /etc/cron.daily/"
    end
    
    after "deploy:setup", "deploy:symlinks:rails"
    after "deploy:setup", "deploy:symlinks:reminders"

  end
  
  namespace :config do
    
    desc "Prompts for the site-specific config after deploy:setup"
    task :setup do
      hostname = Capistrano::CLI.ui.ask("Production Web server: ")
      smtp_server = Capistrano::CLI.ui.ask("Production SMTP server: ")
      require 'yaml'
      spec = {
        "smtp_server" => smtp_server,
        "hostname" => hostname
      }
      run "mkdir -p #{shared_path}/config"
      put(spec.to_yaml, "#{shared_path}/config/config.yml")
    end
    
    desc "Copies the config from shared area after each update"
    task :update do
      run "cp #{shared_path}/config/config.yml #{release_path}/config/config.yml"
    end
    
    # Updates the path to the runner script in the reminders script
    task :update_reminders_path do
      run "sed -i \"s:@current_path@:#{current_path}:\" #{release_path}/script/reminders"
    end
    
    after "deploy:setup", "deploy:config:setup"
    after "deploy:finalize_update", "deploy:config:update"
    after "deploy:finalize_update", "deploy:config:update_reminders_path"
    
  end
  
end

# The following sets up the production sqlite3 database
namespace :db do

  desc <<-DESC
    Creates db folder in the shared path.

    When this recipe is loaded, db:setup is automatically configured \
    to be invoked after deploy:setup. You can skip this task setting \
    the variable :skip_db_setup to true. This is especially useful \
    if you are using this recipe in combination with \
    capistrano-ext/multistaging to avoid multiple db:setup calls \
    when running deploy:setup for all stages one by one.
  DESC
  task :setup, :except => { :no_release => true } do
    run "mkdir -p #{shared_path}/db"
  end

  desc <<-DESC
    [internal] Updates the symlink for production db, files directory \
    where the photos are stored and the gallery URL prefix hack to the \
    just deployed release.
  DESC
  task :symlink, :except => { :no_release => true } do
    run "ln -nfs #{shared_path}/db/production.sqlite3 #{release_path}/db/"
  end

end

after "deploy:setup",           "db:setup"   unless fetch(:skip_db_setup, false)
after "deploy:finalize_update", "db:symlink"
