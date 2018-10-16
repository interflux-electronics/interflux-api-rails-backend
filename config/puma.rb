#!/usr/bin/env puma

# https://github.com/puma/puma
# https://github.com/puma/puma/blob/master/examples/config.rb

directory File.expand_path('../', __dir__)

environment ENV.fetch('RAILS_ENV') { 'development' }

workers 2
threads 0, 5

bind 'tcp://0.0.0.0:3000'
bind 'unix:///var/www/api.interflux.com/shared/sockets/puma.sock'

pidfile '/var/www/api.interflux.com/shared/tmp/pids/puma.pid'
state_path '/var/www/api.interflux.com/shared/tmp/pids/puma.state'
stdout_redirect '/var/www/api.interflux.com/shared/log/puma.stdout.log', '/var/www/api.interflux.com/shared/log/puma.stderr.log', true
activate_control_app 'unix:///var/www/api.interflux.com/shared/tmp/sockets/pumactl.sock', no_token: true

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
