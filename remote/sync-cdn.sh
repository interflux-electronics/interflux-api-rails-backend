#!/usr/bin/env bash

set -e
set -o pipefail

user=jw
server=server.interflux.com
script=sync-cdn.sh

echo "----------"
echo "Syncing production database with production CDN files"
echo "----------"

(
  set -x
  scp -i ~/.ssh/$user@$server remote/uploads/$script $user@$server:~/
  ssh -i ~/.ssh/$user@$server $user@$server "~/$script; rm -f ~/$script"
)

echo "----------"
echo "Done!"
echo "----------"
