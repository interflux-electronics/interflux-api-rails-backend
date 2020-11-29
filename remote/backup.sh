#!/usr/bin/env bash

set -e
set -o pipefail

user=jw
server=server.interflux.com
timestamp=$(date +"%Y-%m-%d-%H%M")

echo "----------"
echo "Backing up Interflux database"
echo "Timestamp: $timestamp"
echo "----------"

(
  set -x
  scp remote/backup-remote.sh $user@$server:~/
  ssh -t $user@$server "~/backup-remote.sh $timestamp; rm -f ~/backup-remote.sh"
)

echo "----------"
echo "Remote database backup complete."
echo "Copying database to local..."
echo "----------"

(
  set -x
  scp -r $user@$server:/var/www/api.interflux.com/db/production-$timestamp/ ./db/backups/
  bin/rails db:data:load_dir dir=backups/production-$timestamp
)

echo "----------"
echo "Done!"
echo "----------"
