#!/usr/bin/env bash

set -e
set -o pipefail

timestamp=$1

(
  set -x
  cd /var/www/api.interflux.com/builds/production/latest/
  rbenv install -s
  gem install bundler
  bin/bundle install
  export RAILS_ENV=production
  bin/rails db:data:dump_dir dir=$timestamp
  mv db/$timestamp/ /var/www/api.interflux.com/db/production-$timestamp/
)
