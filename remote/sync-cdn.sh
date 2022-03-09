#!/usr/bin/env bash

set -e
set -o pipefail

user=bot
server=server.interflux.com

echo "----------"
echo "Sync CDN files with database"
echo "----------"

(
  set -x
  ssh -i ~/.ssh/$user@$server $user@$server "cd /var/www/api.interflux.com/builds/production/latest; export RAILS_ENV=production; bin/rails cdn:report"
)

read -p "Continue? (y/n)" CONT
if [ "$CONT" = "y" ]; then
  echo "Syncing ...";
  (
    set -x
    # ssh -i ~/.ssh/$user@$server $user@$server "cd /var/www/api.interflux.com/builds/production/latest; export RAILS_ENV=production; bin/rails cdn:sync"
  )
fi




echo "----------"
echo "Done!"
echo "----------"
