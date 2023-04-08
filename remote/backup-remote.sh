#!/usr/bin/env bash

set -e
set -o pipefail

timestamp=$1

(
  set -x
  cd /var/www/rails.api.interflux.com/
  bin/rails db:data:dump_dir dir=backups/$timestamp
  tar --create --gzip --verbose --file db/backups/$timestamp.tar.gz db/backups/$timestamp/
)
