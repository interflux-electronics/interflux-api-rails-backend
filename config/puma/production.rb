#!/usr/bin/env puma

environment 'production'

# Make Puma run in the background by daemonizing it after calling `puma -e production`.
daemonize true

# By defining the amount of workers we enable "clustered mode". In clustered
# mode one mother process will spawn X amount of child processes (workers)
# effectively allowing us to leverage each CPU cores for higher concurrency.
# The recommended number of workers is the same amount of CPU cores your server
# has (never more). With 2 workers, you should see 3 puma pids when running:
# `ps aux | grep puma`. One is the mother, 1 mother and 2 are the children.
# Killing the mother also ends the child processes. Killing a child process will
# cause them to respawn with a new pid.
workers 2

# Per worker spin up 0 to 5 threads based on how much traffic is present. With
# 2 workers we would have 0 to 10 threads running + internally created threads.
# Each thread takes up RAM space, thus adjust these to optimise RAM usage.
threads 0, 5

# Where to store the Puma socket.
# This is the socekt Nginx will forward requests to and expects responses from.
bind 'unix:///var/www/api.interflux.com/server/sockets/puma.sock'

# Where to store the Puma control socket.
# This socket allows us to interact with Puma (start, stop, status, ...)
activate_control_app 'unix:///var/www/api.interflux.com/server/sockets/pumactl.sock', auth_token: '12345'

# Where to store Pumag pid, state and logs.
pidfile '/var/www/api.interflux.com/server/pids/puma.pid'
state_path '/var/www/api.interflux.com/server/pids/puma.state'
stdout_redirect '/var/www/api.interflux.com/server/log/puma.stdout.log', '/var/www/api.interflux.com/server/log/puma.stderr.log', true

# Verifies that all workers have checked in to the master process within the
# given timeout. If not the worker process will be restarted. This is not a
# request timeout, it is to protect against a hung or dead process. Setting this
# value will not protect against slow requests. Default value is 60 seconds.
worker_timeout 60

# Additional text to display in process listing
tag 'Puma - Interflux API - Production'
