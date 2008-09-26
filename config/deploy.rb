set :application, "helpdesk"
set :repository,  "git@technology:helpdesk.git"

# If you aren't deploying to /u/apps/#{application} on the target
# servers (which is the default), you can specify the actual location
# via the :deploy_to variable:
set :deploy_to, "/var/rails/#{application}"

# If you aren't using Subversion to manage your source code, specify
# your SCM below:
set :scm, :git

role :app, "technology"
role :web, "technology"
role :db,  "technology", :primary => true