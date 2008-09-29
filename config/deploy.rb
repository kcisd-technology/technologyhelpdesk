set :application, "helpdesk"
set :repository,  "git@development-server:helpdesk.git"

# If you aren't deploying to /u/apps/#{application} on the target
# servers (which is the default), you can specify the actual location
# via the :deploy_to variable:
# set :deploy_to, "/var/www/#{application}"

# If you aren't using Subversion to manage your source code, specify
# your SCM below:
# set :scm, :subversion

role :app, "development-server"
role :web, "development-server"
role :db,  "development-server", :primary => true