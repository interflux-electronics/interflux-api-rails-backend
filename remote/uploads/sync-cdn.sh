#!/usr/bin/env bash

set -e
set -o pipefail

(
  set -x
  cd /var/www/api.interflux.com/builds/production/latest/
  export RAILS_ENV=production
  bin/rails cdn:sync
)
