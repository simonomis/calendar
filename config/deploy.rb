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

  task :start do
    run "touch #{current_release}/tmp/restart.txt"
  end

  task :stop do
    # nothing to do
  end

  desc "Restart the Rails application"
  task :restart do
    run "touch #{current_release}/tmp/restart.txt"
  end
  
  desc "Creates the symlink in www root to the rails application"
  task :rails_symlink do
    run "ln -s #{deploy_to}/#{current_dir}/public #{apache_root}/#{application}"
  end
 
end

after "deploy:cold",  "deploy:rails_symlink"

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
