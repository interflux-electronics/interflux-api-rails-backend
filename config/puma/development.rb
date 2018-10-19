environment 'development'

directory File.expand_path('../../', __dir__)

bind 'tcp://0.0.0.0:3000'
bind 'unix://shared/tmp/sockets/puma.sock'

pidfile 'shared/tmp/pids/puma.pid'
state_path 'shared/tmp/pids/puma.state'
stdout_redirect 'shared/log/puma.stdout.log', 'shared/log/puma.stderr.log', true
activate_control_app 'unix://shared/tmp/sockets/pumactl.sock', no_token: true
