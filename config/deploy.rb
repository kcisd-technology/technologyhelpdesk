set :application, "Technology Helpdesk"
set :repository,  "git@technology:helpdesk.git"
set :scm, :git
set :branch, 'master'
set :user, 'wadewest'
set :deploy_to, '/var/rails/helpdesk'

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
  
  desc "Link to the server database.yml file"
  task :link_database_config, :roles => :app do
    run "ln -s #{deploy_to}/shared/system/database.yml #{deploy_to}/current/config/database.yml"
  end
end

after 'deploy:symlink', 'deploy:link_database_config'
after 'deploy:link_database_config', 'deploy:migrate'