set :application, "helpdesk"
set :repository,  "git@technology:helpdesk.git"

# If you aren't deploying to /u/apps/#{application} on the target
# servers (which is the default), you can specify the actual location
# via the :deploy_to variable:
set :deploy_to, "/var/rails/#{application}"
set :user, 'wadewest'

# If you aren't using Subversion to manage your source code, specify
# your SCM below:
set :scm, :git
set :branch, 'master'

role :app, "technology"
role :web, "technology"
role :db,  "technology", :primary => true

namespace :deploy do
  desc "Restart Application" 
  task :restart, :roles => :app do
    run "touch #{current_path}/tmp/restart.txt" 
  end
  desc "Start Application -- not needed for Passenger" 
  task :start, :roles => :app do
    # nothing -- need to override default cap start task when using Passenger
  end
end

task :link_database_config do
  run "ln -s #{deploy_to}/shared/system/database.yml #{deploy_to}/current/config/database.yml"
end
after "deploy:symlink", :link_database_config
