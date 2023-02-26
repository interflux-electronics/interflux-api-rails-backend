#!/usr/bin/env bash

set -e
set -o pipefail

timestamp=$1

(
  set -x
  cd /var/www/rails.api.interflux.com/
  export RAILS_ENV=production
  bin/rails db:data:dump_dir dir=backups/$timestamp
)
