environment 'production'

# directory File.expand_path('../../../../', __dir__)

directory '/var/www/api.interflux.com/releases/latest'

# The socket from which to serve the Rails app
bind 'unix:///var/www/api.interflux/server/puma.sock'
pidfile '/var/www/api.interflux/server/puma.pid'
state_path '/var/www/api.interflux/server/puma.state'
stdout_redirect '/var/www/api.interflux/server/puma.stdout.log', 'server/puma.stderr.log', true
activate_control_app 'unix:///var/www/api.interflux/server/pumactl.sock', no_token: true

daemonize true

# TODO: Investigate phased restart to avoid loss of Active Jobs

preload_app!

before_fork do
  ActiveRecord::Base.connection_pool.disconnect! if defined?(ActiveRecord)
end

on_restart do
  puts 'On restart...'
end

on_worker_boot do
  puts 'On worker boot...'
  ActiveSupport.on_load(:active_record) do
    ActiveRecord::Base.establish_connection
  end
end
