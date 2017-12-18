#!/bin/bash

export RAILS_ENV=production;
bundle install
rake db:migrate
bundle exec pumactl -S ./shared/pids/puma.state stop
bundle exec puma
