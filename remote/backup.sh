#!/usr/bin/env bash

set -e
set -o pipefail

url=admin@frankfurt.server.interflux.com
timestamp="$(date -u +"%Y-%m-%d-%H%M%S")-UTC"

echo "----------"
echo "Backing up Interflux database"
echo "Timestamp: $timestamp"
echo "----------"

(
  set -x
  scp -i ~/.ssh/$url remote/backup-remote.sh $url:~/
  ssh -i ~/.ssh/$url $url "~/backup-remote.sh $timestamp; rm -f ~/backup-remote.sh"
)

echo "----------"
echo "Remote database backup complete."
echo "Copying database to local..."
echo "----------"

(
  set -x
  scp -i ~/.ssh/$url -r $url:/var/www/rails.api.interflux.com/db/backups/$timestamp/ ./db/backups
  mv ./db/backups/$timestamp ./db/backups/production-$timestamp
  bin/rails db:data:load_dir dir=backups/production-$timestamp
)

echo "----------"
echo "Done!"
echo "----------"
