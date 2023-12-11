#!/usr/bin/env bash

set -e
set -o pipefail

user=bot
server=server.interflux.com
backup=$1

echo "----------"
echo "Restoring database backup $backup"
echo "----------"

(
  set -x
  scp -i ~/.ssh/$user@$server remote/restore-backup-remote.sh $user@$server:~/
  ssh -i ~/.ssh/$user@$server $user@$server "~/restore-backup-remote.sh $backup; rm -f ~/backup-remote.sh"
)

echo "----------"
echo "Done!"
echo "----------"
