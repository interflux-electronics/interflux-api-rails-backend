#!/usr/bin/env puma

# server_dir = '/var/www/api.interflux.com/server'

environment 'production'

workers 2
threads 0, 5

bind 'unix:///var/www/api.interflux.com/server/sockets/puma.sock'

pidfile '/var/www/api.interflux.com/server/pids/puma.pid'
state_path '/var/www/api.interflux.com/server/pids/puma.state'
stdout_redirect '/var/www/api.interflux.com/server/log/puma.stdout.log', '/var/www/api.interflux.com/server/log/puma.stderr.log', true
activate_control_app 'unix:///var/www/api.interflux.com/server/sockets/pumactl.sock', no_token: true

daemonize true

preload_app!

before_fork do
  ActiveRecord::Base.connection_pool.disconnect! if defined?(ActiveRecord)
end

on_worker_boot do
  ActiveSupport.on_load(:active_record) do
    ActiveRecord::Base.establish_connection
  end
end
