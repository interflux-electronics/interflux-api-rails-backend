require 'mina/rails'
require 'mina/git'
require 'mina/puma'
require 'mina/rbenv'

set :application_name, 'Interflux API'

set :user, 'jw' # Username in the server to SSH to
set :domain, 'api.interflux.com' # The hostname to SSH to
set :deploy_to, '/var/www/api.interflux.com' # Path to deploy into
set :repository, 'git@github.com:janwerkhoven/api.interflux.com.git' # Git repo to clone from
set :branch, 'feature/mina-deploy-pipeline' # Git branch to deploy

# Shared dirs and files will be symlinked into the app-folder by the 'deploy:link_shared_paths' step.
# Some plugins already add folders to shared_dirs like `mina/rails` add `public/assets`, `vendor/bundle` and many more
# run `mina -d` to see all folders and files already included in `shared_dirs` and `shared_files`
set :shared_dirs, fetch(:shared_dirs, []).push('public/assets', 'tmp/pids', 'tmp/sockets', 'tmp/cache')
# set :shared_files, fetch(:shared_files, []).push('config/database.yml', 'config/secrets.yml')

# Puma
# https://github.com/sandelius/mina-puma
set :puma_socket, '/var/www/api.interflux.com/shared/tmp/sockets/puma.sock'
set :puma_pid, '/var/www/api.interflux.com/shared/tmp/pids/puma.pid'
set :puma_state, '/var/www/api.interflux.com/shared/tmp/sockets/puma.state'
set :pumactl_socket, '/var/www/api.interflux.com/shared/tmp/sockets/pumactl.sock'

# This task is the environment that is loaded for all remote run commands, such as
# `mina deploy` or `mina rake`.
task :remote_environment do
  # If you're using rbenv, use this to load the rbenv environment.
  # Be sure to commit your .ruby-version or .rbenv-version to your repository.
  invoke :'rbenv:load'
end

# Put any custom commands you need to run at setup
# All paths in `shared_dirs` and `shared_paths` will be created on their own.
task :setup do
  # Install the right version of Ruby with rbenv, skip if already exists
  command %(rbenv install 2.4.1 --skip-existing)

  # Puma needs a place to store its pid file and socket file.
  queue! %(mkdir -p "#{deploy_to}/#{shared_path}/tmp/sockets")
  queue! %(chmod g+rx,u+rwx "#{deploy_to}/#{shared_path}/tmp/sockets")
  queue! %(mkdir -p "#{deploy_to}/#{shared_path}/tmp/pids")
  queue! %(chmod g+rx,u+rwx "#{deploy_to}/#{shared_path}/tmp/pids")
end

desc 'Deploys the current version to the server.'
task :deploy do
  # Verify you pushed your local to the remote origin
  invoke :'git:ensure_pushed'

  # All commands to turn an empty folder into a fully set up app
  deploy do
    invoke :'git:clone'
    invoke :'deploy:link_shared_paths'
    invoke :'bundle:install'
    invoke :'rails:db_migrate'
    invoke :'deploy:cleanup'

    on :launch do
      invoke :'puma:phased_restart'
    end
  end

  # you can use `run :local` to run tasks on local machine before of after the deploy scripts
  # run(:local){ say 'done' }
end

# For help in making your deploy script, see the Mina documentation:
#
#  - https://github.com/mina-deploy/mina/tree/master/docs
