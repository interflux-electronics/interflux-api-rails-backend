#!/usr/bin/env puma

app_dir = File.expand_path('../../', __dir__)
server_dir = "#{app_dir}/server"

environment 'development'

workers 2
threads 0, 5

bind 'tcp://0.0.0.0:3000'
bind "unix://#{server_dir}/sockets/puma.sock"

pidfile "#{server_dir}/pids/puma.pid"
state_path "#{server_dir}/pids/puma.state"
stdout_redirect "#{server_dir}/log/puma.stdout.log", "#{server_dir}/log/puma.stderr.log", true
activate_control_app "unix://#{server_dir}/sockets/pumactl.sock", no_token: true

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
