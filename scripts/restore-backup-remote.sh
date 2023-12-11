#!/usr/bin/env bash

set -e
set -o pipefail

backup=$1

(
  set -x
  cd /var/www/api.interflux.com/builds/production/latest/
  cp -r "/var/www/api.interflux.com/db/$backup" ./db/
  export RAILS_ENV=production
  bin/rails db:data:load_dir dir=$backup
)
