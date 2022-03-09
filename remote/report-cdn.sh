#!/usr/bin/env bash

set -e
set -o pipefail

user=jw
server=server.interflux.com
script=report-cdn.sh

echo "----------"
echo "Reporting difference between CDN and database"
echo "----------"

(
  set -x
  scp -i ~/.ssh/$user@$server remote/uploads/$script $user@$server:~/
  ssh -i ~/.ssh/$user@$server $user@$server "~/$script; rm -f ~/$script"
)

echo "----------"
echo "Done!"
echo "----------"
