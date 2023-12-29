#!/usr/bin/env bash

set -e
set -o pipefail

# url=admin@frankfurt.server.interflux.com
server=frankfurt # Configured in ~/.ssh/config
timestamp="$(date -u +"%Y-%m-%d-%H%M%S")-UTC"

echo "----------"
echo "Backing up Interflux database"
echo "Timestamp: $timestamp"
echo "----------"

(
  set -x
  scp scripts/backup-remote.sh $server:~/
  ssh $server "~/backup-remote.sh $timestamp; rm -f ~/backup-remote.sh"
)

echo "----------"
echo "Remote database backup complete."
echo "Copying database to local..."
echo "----------"

(
  set -x
  scp $server:/var/www/rails.api.interflux.com/db/backups/$timestamp.tar.gz ./db/backups
  tar --extract --file db/backups/$timestamp.tar.gz
  bin/rails db:data:load_dir dir=backups/$timestamp
  rm db/backups/$timestamp.tar.gz
)

echo "----------"
echo "Done!"
echo "----------"
