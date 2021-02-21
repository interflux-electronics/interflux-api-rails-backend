#!/usr/bin/env bash

set -e
set -o pipefail

user=bot
server=server.interflux.com
domain=api.interflux.com
branch=$(git rev-parse --abbrev-ref HEAD)
revision=$(git rev-parse --short HEAD)

echo "----------"
echo "Deploying:"
echo $domain
echo $user@$server
echo $branch
echo $revision
echo "----------"

(
  set -x
  scp -i ~/.ssh/$user@$server remote/deploy-remote.sh $user@$server:~/
  ssh -i ~/.ssh/$user@$server $user@$server "~/deploy-remote.sh $domain $branch $revision; rm -f ~/deploy-remote.sh"
)
