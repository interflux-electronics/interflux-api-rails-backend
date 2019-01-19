#!/usr/bin/env bash

set -e
set -o pipefail

echo "----------"
branch=$(git rev-parse --abbrev-ref HEAD)
revision=$(git rev-parse --short HEAD)
echo "----------"
echo $branch
echo $revision
echo "----------"
echo "scp install.sh deploy@server-singapore.interflux.com:/var/www/api.interflux.com"
scp install.sh deploy@server-singapore.interflux.com:/var/www/api.interflux.com
echo "----------"
echo 'ssh deploy@server-singapore.interflux.com "cd /var/www/api.interflux.com; ./install.sh $branch $revision; rm ./install.sh"'
ssh deploy@server-singapore.interflux.com "cd /var/www/api.interflux.com; ./install.sh $branch $revision; rm ./install.sh"
